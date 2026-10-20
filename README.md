# Bookshelf

A small reading tracker built on the free [Open Library](https://openlibrary.org/developers/api) API. It exists to show a multi-package Flutter architecture end to end: core and normal features, cubits, dependency injection, feature flags, navigation between features, a design system with Widgetbook, and the tooling that keeps it all in line.

Search for books, add them to a shelf, review the ones you finish and track a yearly goal.

## Getting started

Everything runs through [FVM](https://fvm.app). The Flutter version is pinned in `.fvmrc`.

```sh
fvm install
fvm flutter pub get
fvm dart run melos bootstrap
fvm dart run melos run gen --no-select
fvm dart run melos run run:dev
```

Melos reads `sdkPath: .fvm/flutter_sdk` from the root `pubspec.yaml`, so every script it runs uses the pinned SDK. Run `pub get` once before melos in a fresh clone: `dart run` cannot resolve a new pub workspace by itself.

## Architecture

```
packages/
├── app/
│   ├── bookshelf/        composition root: flavours, bootstrap, DI, theme
│   ├── navigation/       go_router, the app shell, navigation implementations
│   └── widgetbook/       the catalogue: every Widgetbook in one app, for hosting
├── features/
│   ├── my_books/         the user's shelves, with a Widgetbook
│   ├── discover/         search and trending
│   ├── book_details/     a book plus the add-to-shelf flow, with a Widgetbook
│   ├── reading_stats/    goal progress and a monthly breakdown
│   ├── settings/         theme, goal, developer options entry point
│   └── debug_menu/       feature flag overrides (non-production only)
└── utilities/
    ├── core_analysis/    lint rules
    ├── core_prelude/     Result and AppFailure
    ├── core_di/          the GetIt instance and feature scopes
    ├── core_config/      AppEnvironment and AppConfig
    ├── core_storage/     key value storage behind an interface
    ├── core_network/     a JSON client that returns Results
    ├── core_design_system/  design tokens, the theme, shared components, with a Widgetbook
    ├── core_books/       book models, the catalogue and the local shelf
    ├── core_l10n/        supported locales and the language preference
    ├── core_feature_flags/
    └── core_widgetbook/  what every Widgetbook shares
```

Dependencies only point one way:

- **app** can depend on features and utilities
- **features** can only depend on utilities, never on each other
- **utilities** can only depend on other utilities
- **sandboxes**, which are each package's Widgetbook, can only depend on the package they host and on utilities. Only they may depend on `core_widgetbook` or import a core package's `fakes.dart`.
- the **catalogue**, `packages/app/widgetbook`, puts every Widgetbook together. It may depend on any Widgetbook, feature or utility, and nothing may depend on it.

`melos run boundaries` fails the build if a pubspec breaks these rules.

### A feature

Every feature has the same shape. `discover` is a good one to read first.

```
lib/
├── discover.dart                       barrel: the flow, the navigation contract, the strings
└── src/
    ├── domain/
    │   ├── di/di_init.dart             injectable config, pushed as a GetIt scope
    │   └── navigation/                 what the feature needs from the outside world
    ├── l10n/                           the feature's own ARB files and generated strings
    └── presentation/
        ├── flow/                       entry point: DI, cubits, internal navigation
        ├── cubits/                     one cubit per UI concern, sealed states
        └── view/                       pages and widgets
```

- The **flow** is the only public widget. It pushes the feature's DI scope in `initState`, drops it in `dispose`, and provides the cubits.
- **Cubits** sit between the UI and services. Business logic lives in services, either in a utility (`IBookCatalogService`) or in the feature's own domain layer (`ReadingStatsCalculator`).
- **Navigation out of a feature** goes through an interface such as `IDiscoverNavigation`. The feature never knows about routes; the `navigation` package implements the interface with go_router.
- **Navigation inside a feature** uses `flow_builder`. `book_details` moves from the overview to choosing a shelf to writing a review by updating its flow state.

### A core feature

Utilities hold whatever more than one feature needs. `core_books` owns the `Book` model, the Open Library catalogue and the user's shelf. It exposes interfaces and keeps the implementations private, registered once at startup in the root GetIt scope.

Services return `Result<S, F>` from `core_prelude` rather than throwing. Each layer maps failures into its own terms: `NetworkFailure` in `core_network` becomes `CatalogFailure` in `core_books`, which a cubit turns into a message.

### How the app pulls it together

1. `main_development.dart` calls `bootstrap(AppEnvironment.development)`.
2. `bootstrap` sets the bloc observer and calls `initialize(config)` in `di/di_initializer.dart`.
3. `initialize` registers `AppConfig`, calls each utility's `initialize()`, registers the navigation implementations, then loads feature flags before the first frame.
4. `App` provides the app-wide cubits (theme, language and feature flags) and hands `router` from the `navigation` package to `MaterialApp.router`.
5. The router builds a `StatefulShellRoute` of feature flows. Each flow sets up its own scope when it first appears.

### Sandboxes

A package with UI runs on its own, against fakes, in a Widgetbook nested inside it. See [Widgetbook](#widgetbook).

## Localisation

There is no app-wide ARB file. Each package that shows text owns its strings, next to the code that uses them:

```
packages/features/discover/
├── l10n.yaml
└── lib/src/l10n/
    ├── arb/
    │   ├── discover_en.arb       the template, with a description for every message
    │   └── discover_es.arb
    ├── gen/                      DiscoverLocalizations, generated by flutter gen-l10n
    └── l10n.dart                 context.l10n, private to the package
```

Eight packages work this way: the five features with UI, `core_design_system`, `core_books` and `navigation`. Inside a package, widgets read `context.l10n.title`. The extension is never exported, so every package gets its own `context.l10n` without clashing with anyone else's.

Text that several features need lives in the core package that owns the concept. `core_books` translates shelf names, "Unknown author" and its own failures, and exposes them as extensions:

```dart
Text(entry.status.label(context))
Text(book.byline(context))
ErrorView(message: failure.describe(context))
```

Domain objects carry no user-facing English. Cubit states hold the typed failure (`SearchFailure(query, failure)`), and the widget asks it to describe itself in the current language. `AppFailure.message` is for logs.

The app composes everything in one place:

```dart
localizationsDelegates: const [
  ...GlobalMaterialLocalizations.delegates,
  CoreDesignSystemLocalizations.delegate,
  CoreBooksLocalizations.delegate,
  ...featureLocalizationsDelegates,
],
```

`featureLocalizationsDelegates` lives in the `navigation` package, next to the routes. That package already knows every feature it can show, so registering a feature's strings sits right beside registering its route. Each Widgetbook registers only the delegates of the packages it hosts, so you can check a feature's translations in isolation.

Pick a language under **Settings → Language**. `core_l10n` stores the choice and the app rebuilds in that locale. Numbers, percentages and month names come from `intl`, so Spanish shows "5,0" and "8 %".

Two scripts keep translations honest:

- `melos run l10n` regenerates every package's localizations.
- `melos run l10n:check` fails when a package is missing a whole locale (that would crash at runtime), a message is untranslated or stale, or a template message has no description for translators.

The debug menu and Widgetbook's knobs are developer tools and stay in English.

## Design system

`core_design_system` is the Bookshelf design system: the design tokens, the theme built on them and the shared components. Nothing outside its tokens hard-codes a colour, a size or a font.

```
lib/src/tokens/       BookshelfColors, BookshelfTypography, Spacing, Radii, Sizes
lib/src/theme/        AppTheme: how Material's components use the tokens
lib/src/components/   BookCover, BookListTile, EmptyState, ErrorView, RatingStars, SectionHeader, Tag
```

### Tokens

The tokens are written by hand, in the shape a generator would write them from a design file. [docs/design_tokens.md](docs/design_tokens.md) describes how they would be generated from Figma.

One rule decides the shape of each class:

- A group that is the same in every theme mode is a class of constants, so `const EdgeInsets.all(Spacing.m)` works.
- Colours change with the theme, so `BookshelfColors` is a `ThemeExtension` with a constant for each mode: `BookshelfColors.light`, `BookshelfColors.dark`, and `BookshelfColors.modes` for all of them, with `lerp` and `copyWith` for theme animations.

The colour roles are named after Material's, so `toColorScheme()` turns them into the theme's `ColorScheme` and Material's own widgets use them. `BookshelfTypography.toTextTheme()` does the same for the 15 text styles. A role Material has no place for, such as `rating`, is read with `BookshelfColors.of(context).rating`. Every class also has `tokens` and `descriptions` maps, which Widgetbook uses to list them.

The colours are the Material tonal palettes `ColorScheme.fromSeed` would generate from the brand brown, written out as values, plus an amber of Bookshelf's own for rating stars.

`AppTheme` decides how Material's components use the tokens, such as cards taking `Radii.l`. It has no values of its own, so a change to a token reaches every component without touching it.

### Design rules as tests

- `test/tokens/contrast_test.dart` checks WCAG AA contrast for every pair of text and background, and for graphics such as rating stars, in every mode. Anyone can change a colour. A pull request that makes text hard to read fails.
- The design system's Widgetbook test opens every token page and component in every mode.

## Widgetbook

A package with UI can have a [Widgetbook](https://www.widgetbook.io) nested inside it, which runs that package on its own, against fakes. It is the package's sandbox. So far the design system, `book_details` and `my_books` have one.

| Widgetbook | Shows | Run |
| --- | --- | --- |
| `packages/utilities/core_design_system/widgetbook` | Tokens and components | `melos run widgetbook:design_system` |
| `packages/features/book_details/widgetbook` | The book details flow, fully interactive | `melos run widgetbook:book_details` |
| `packages/features/my_books/widgetbook` | My books, in each state its screen can be in | `melos run widgetbook:my_books` |
| `packages/app/widgetbook`, the catalogue | All of the above, in one app | `melos run widgetbook` |

Each also has a launch configuration. A Widgetbook may only depend on the package it hosts and on utilities, so a feature's Widgetbook cannot see other features, and the design system's cannot see any.

Teams work in their own package's Widgetbook, where it runs on its own and cannot reach anything else. The catalogue puts them all together for hosting: one Widgetbook Cloud project instead of one per package, and one link for designers. A design system change is then reviewed together with every screen that uses it. The catalogue has no use cases of its own. It shows each Widgetbook's generated navigation tree and registers each one's fakes.

Knobs only change what Widgetbook shows. They never write back to the code or the tokens. What the app shows comes from feature code, and how it looks comes from the tokens. A designer uses Widgetbook to find edge cases and review changes. Knob values are part of the URL, so a link shows someone exactly what you see. Changes still go through a pull request.

### A feature's Widgetbook

A feature only exports its flow, so each use case opens the flow exactly as the app does. Nothing reaches into the feature's `src/`, so what you see is what ships.

- **Fakes.** `Fakes.register` in `lib/fakes.dart` puts a fake of every service the flow resolves from GetIt in the root scope, where the app puts the real ones.
- **A use case is a starting point.** Book details has Full details, Sparse details, Slow catalogue, Offline with a saved copy and Not found. My books has Loading, Empty shelf, Shelf and Offline.
- **The flow is live.** Tap through it: add the book to a shelf, write a review, tap a subject.
- **Knobs change the fakes.** Every book details use case has knobs for the book, how the catalogue answers, what is already on the shelf, the review step flag and whether saving fails. `FakeSetup` applies knobs only when they change, so rebuilding for a new theme does not undo what you did in the flow.
- **Some knobs restart the flow, some don't.** Knobs that decide where it starts, such as the book, restart it, because the flow is keyed by them. Knobs it reads as it goes change while it runs: in Full details, tap Add to shelf, switch off Review step, then pick Read. In My books, drag Books on the shelf and the filter you picked stays picked.
- **Leaving is logged.** When a feature tries to leave, `showNavigation` shows the call in a snack bar, such as `Book details → back()`, instead of going anywhere. That makes the feature's contract with the rest of the app visible.
- **The same setup is tested.** The test opens every use case in every mode and walks the flows, with no network or app shell.

To give a feature a Widgetbook, copy `packages/features/my_books/widgetbook`, register fakes for what its flow resolves, write a use case per starting point, and add the package to the workspace and a `widgetbook:<feature>` script.

### Fakes and shared setup

Fakes live next to the interface they fake:

- `package:core_books/fakes.dart`: `FakeBookCatalogService`, `FakeLibraryService` and `SampleBooks`, real Open Library works so their covers load, plus one with nothing but a title
- `package:core_feature_flags/fakes.dart`: `FakeFeatureFlagService`

Every Widgetbook uses the same fakes, and only its navigation fake is its own. Each fake has a `shared` instance, such as `FakeLibraryService.shared`, and `registerFake` from `core_widgetbook` registers it only once, so several Widgetbooks can run in the catalogue and see the same shelf. Each use case sets the fakes up for itself when it opens, so what one flow did never leaks into another. They add no packages and no dependencies. Dart only compiles the libraries something imports, so the app never contains them, and `melos run boundaries` fails if app, feature or utility code imports a `fakes.dart`.

`core_widgetbook` holds what the Widgetbooks share: `BookshelfWidgetbook`, which sets up Widgetbook with every theme mode, locale, viewport and addon, plus `FakeSetup` and `showNavigation`. Only Widgetbooks may depend on it.

### Design system

`packages/utilities/core_design_system/widgetbook` shows:

- **Tokens**: every colour with its hex value and what it is for, every text style, and spacing, radius and size drawn to scale
- **Components**: everything in `core_design_system`, with knobs. The knobs offer token names rather than numbers, because components should only ever be given values from the design system.

The addons switch between every theme mode, English and Spanish, text scale, device viewports, alignment and the widget inspector. The modes come from `BookshelfColors.modes`, so a new mode shows up without a change to Widgetbook.

### Writing use cases

A use case is a function annotated with `@UseCase`. `melos run gen` rebuilds each Widgetbook's navigation tree in `widgetbook.directories.g.dart`. A use case can also link to its frame in Figma with `designLink`.

Two things are worth knowing:

- Widgetbook is built on the SDK's `package:flutter/material.dart` and Bookshelf on `material_ui`. Their `Theme` and `ThemeData` are different types, so Widgetbook's `MaterialThemeAddon` cannot take our themes. `BookshelfWidgetbook` runs each use case inside a `material_ui` `MaterialApp` of its own, and a generic `ThemeAddon<ThemeData>` applies the theme.
- `widgetbook_generator` reports usage to Mixpanel on every build by default: a hash of your git email, the repository's first commit and the remote's owner URL. Each Widgetbook's `build.yaml` turns it off.

### Hosting

The catalogue is on GitHub Pages, so anyone can use every Widgetbook without Flutter: [henrykeene.github.io/FlutterAtScale](https://henrykeene.github.io/FlutterAtScale/). `.github/workflows/widgetbook_pages.yaml` publishes `main`'s at the root of the site. It also publishes each pull request's at `pr-preview/pr-<number>/` and comments the link on the pull request, so a reviewer can try a changed flow before it merges. The preview is removed when the pull request closes. A link can open a use case with its knobs already set, such as `#/?path=book-details/bookdetailsflow/full-details&knobs={Review%20step:false}`.

The catalogue is also on [Widgetbook Cloud](https://www.widgetbook.io/cloud), as one project. `.github/workflows/widgetbook_cloud.yaml` uploads a build on every push to a branch. When a pull request is open, Widgetbook Cloud compares its build with the base branch's and posts a review on the pull request, showing which use cases changed. The workflow needs the project's API key as the `WIDGETBOOK_API_KEY` repository secret, and skips the upload without it.

Widgetbook Cloud reviews the use cases build_runner describes in the uploading package's `.dart_tool`. Each package's Widgetbook lists `widgetbook_generator` as a normal dependency rather than a dev one, so building the catalogue describes every Widgetbook's use cases, not just its own.

To upload a build by hand, run this from `packages/app/widgetbook`, with the pinned Flutter on your `PATH`:

```sh
dart run build_runner build
flutter build web
dart pub global run widgetbook_cli:widgetbook cloud build push \
  --api-key "$WIDGETBOOK_API_KEY" --repository <owner>/<repo> --actor <github-user>
```

The CLI names the repository after the local folder, so pass `--repository` and `--actor` by hand to match what CI reports.

## Feature flags

Flags live in `core_feature_flags` as an enum. Each one resolves in this order:

1. **Override**, set in the debug menu and ignored in production
2. **Remote**, from `assets/remote_flags.json`, which stands in for Firebase Remote Config or LaunchDarkly
3. **Default**, per environment, in `flag_defaults.dart`

They are used at three levels:

| Level | Example | How |
| --- | --- | --- |
| App | `readingStats` adds the Stats tab and its route | `AppShell` reads `context.isFeatureEnabled`, the router redirects and refreshes on flag changes |
| Business logic | `bookReviews` adds a review step when a book is marked as read | `ShelveBookCubit.needsReview` asks `IFeatureFlagService` |
| UI | `shelfGrid` switches My books to a grid, `trendingBooks` shows trending before a search | `FeatureGate(flag: ..., fallback: ..., child: ...)` |

Open **Settings → Developer options** in a development or staging build to flip them live. To add a flag, add a value to `FeatureFlag` and a default in `flagDefaults`.

## Tooling

### Melos

| Script | What it does |
| --- | --- |
| `gen` | Runs build_runner wherever it is a dependency |
| `l10n` | Regenerates localizations in every package with an `l10n.yaml` |
| `l10n:check` | Fails on a missing locale, translation or translator description |
| `analyze` | `flutter analyze --fatal-infos` in every package |
| `test` | Flutter and pure Dart tests across the workspace |
| `test:integration` | Drives the app on a booted simulator or device |
| `coverage` | Flutter tests with coverage |
| `format:check` | Fails on unformatted code |
| `boundaries` | Fails on a dependency that breaks the layer rules |
| `check` | `format:check`, `boundaries`, `l10n:check`, `analyze` and `test`, as CI runs them |
| `new:feature`, `new:core` | Scaffold a package from a mason brick |
| `widgetbook` | Run the catalogue, every Widgetbook in one app, in Chrome |
| `widgetbook:design_system` | Run the design system's Widgetbook, its tokens and components, in Chrome |
| `widgetbook:book_details` | Run the book_details feature on its own, against fakes, in Widgetbook |
| `widgetbook:my_books` | Run the my_books feature on its own, against fakes, in Widgetbook |
| `run:dev`, `run:staging`, `run:prod` | Run a flavour |

Run any of them with `fvm dart run melos run <script>`. Add `--no-select` to skip the package prompt.

### Mason

Three bricks live in `bricks/`. Activate the CLI once with `fvm dart pub global activate mason_cli`.

- **feature** creates a package under `packages/features` with a flow, a flow state, a cubit, a page, a DI scope, an optional navigation contract, its own English and Spanish ARB files and a cubit test.
- **core_package** creates a utility under `packages/utilities` with a service interface, its implementation, a failure type and a test.
- **cubit** creates a cubit and its sealed state wherever you point it.

```sh
fvm dart run melos run new:feature
fvm dart run melos run new:core
dart pub global run mason_cli:mason make cubit -o packages/features/discover/lib/src/presentation/cubits
```

The feature and core hooks add the new package to the workspace, resolve dependencies, generate its localizations and DI config, tidy imports and format it, then tell you what to wire up in the app.

### CI

`.github/workflows/ci.yaml` installs FVM and the pinned Flutter through `.github/actions/setup_flutter`, checks the committed DI config, localizations and Widgetbook trees are up to date, runs `melos run check`, and builds a development APK. Two more workflows host the Widgetbooks, as described under [Hosting](#hosting): `widgetbook_pages.yaml` publishes the catalogue to GitHub Pages, and `widgetbook_cloud.yaml` uploads it to Widgetbook Cloud.

### Editors

`.vscode/launch.json` has a launch configuration for each flavour and for each Widgetbook.

## What a real app would do differently

This is a demo, so a few things are deliberately light:

- The shelf is JSON in shared preferences. A real app would use a database such as Drift.
- Remote flags come from a bundled JSON file rather than a remote config service.
- Flavours are Dart entry points only. There are no native Android flavours or iOS schemes.
- Spanish is the only second language, and the translations haven't been through a translator.
- The design tokens are written by hand. [docs/design_tokens.md](docs/design_tokens.md) describes generating them from Figma.
- The typography tokens name Roboto without bundling it. Android has it, and other platforms fall back to their system font. A real app would ship its brand font in `core_design_system`.
- Only three packages have a Widgetbook so far.

## Licence

[MIT](LICENSE).
