# Design tokens from Figma

This is a plan, not something the repo does yet. Bookshelf's design tokens are written by hand in [`core_design_system/lib/src/tokens/`](../packages/utilities/core_design_system/lib/src/tokens/), in the shape a generator would write them. This page describes how they would be generated from a Figma file instead, and what is worth knowing before building it.

## Why generate them

Designers already define colours, type and spacing in Figma. Retyping them in Dart means two sources of truth that drift apart. Generating the Dart from the design file means:

- a design change arrives as a pull request, with every changed value in the diff
- nobody edits token values by hand
- tests and Widgetbook check every change before it ships

## The pipeline

```
Figma variables
   │   exported through the REST API or a plugin
   ▼
*.tokens.json                W3C design tokens: the contract
   │   a generator
   ▼
lib/src/tokens/*.dart        BookshelfColors, BookshelfTypography, Spacing, Radii, Sizes
   │
   ▼
AppTheme                     hand-written: how Material's components use the tokens
```

The middle step matters most. The [Design Tokens Format Module](https://www.designtokens.org/tr/2025.10/format/) from the W3C Design Tokens Community Group reached its first stable version, 2025.10, in October 2025. Figma plugins, Tokens Studio and Style Dictionary read and write it. Its [resolver module](https://www.designtokens.org/tr/2025.10/resolver/) describes modes: token files that always apply are sets, and files that depend on a choice, such as light or dark, are contexts of a modifier.

With that format in the middle, each side can change on its own. Swapping how tokens leave Figma changes no Dart, and changing the generator changes nothing in Figma.

## The design file

The Figma file would have four variable collections:

| Collection | Modes | Holds |
| --- | --- | --- |
| Primitives | one | Tonal palettes, the space scale, font sizes, weights and line heights. Hidden from publishing, so designers use roles. |
| Theme | Light, Dark | Every Material colour role, plus `Rating`, each an alias to a palette tone |
| Layout | one | Spacing, radius and size |
| Typography | one | The 15 Material text styles, each as the five variables bound to a text style |

The naming convention is the contract between design and code:

- **Names become paths.** `Color/On Primary` becomes the token `color.on-primary`, and `BookshelfColors.onPrimary` in Dart.
- **Modes become contexts.** A collection with one mode becomes a set. One with several modes becomes a modifier, with a file per mode.
- **Scopes give the type.** Figma has a single number type, so a variable's scopes say what it is: `FONT_WEIGHT` is a font weight, `OPACITY` a plain number, and anything else a length in pixels.
- **Text styles become one token.** A group of `Font Family`, `Font Size`, `Font Weight`, `Line Height` and `Letter Spacing` variables becomes one typography token. The format measures line height as a multiple of the font size, while Figma uses pixels, so it is divided out.
- **Primitives stay in Figma.** Only roles reach the code.

## Generating the Dart

One rule decides the shape of each class, and the hand-written files already follow it:

- A group that is the same in every mode becomes constants, so `const EdgeInsets.all(Spacing.m)` keeps working.
- A group that changes with the theme becomes a `ThemeExtension` with a constant per mode, such as `BookshelfColors.light`. A new High contrast mode in Figma would become `BookshelfColors.highContrast`, and Widgetbook would offer it with no other change.

Tokens named after Material's colour roles and text styles map onto a `ColorScheme` and a `TextTheme`, so Material's widgets use them. Anything else, such as `rating`, is read with `BookshelfColors.of(context)`. Every class also carries `tokens` and `descriptions` maps, so Widgetbook can list each token with the description a designer wrote in Figma.

Because the hand-written files have exactly this shape, a generator would replace them file for file and nothing that uses them would change.

### Which generator

Material has moved out of the Flutter SDK into the [`material_ui`](https://pub.dev/packages/material_ui) package, whose `ThemeData` is a different type from `package:flutter/material.dart`'s. The Figma and DTCG generators on pub.dev write the SDK's types, so their output would not plug into this theme. The two realistic options are:

- [Style Dictionary](https://styledictionary.com), which reads the format, with a custom format that writes these Dart classes. It brings Node into the build.
- A small Dart command line tool in three stages: Figma variables to token files, reading and resolving token files, and writing Dart. It keeps the whole toolchain in Dart and is a few hundred lines per stage.

## Getting the variables out of Figma

- **The REST API.** `GET /v1/files/:file_key/variables/local` returns every collection, mode and variable, with aliases intact. It needs a token with the `file_variables:read` scope, and it is only open to full seats in Enterprise organisations ([Figma's docs](https://developers.figma.com/docs/rest-api/variables-endpoints/)). It only reads, so it cannot change the file.
- **A plugin, on any paid plan.** Plugins read variables through Figma's Plugin API on every plan. Tokens Studio and several community plugins export the token format directly. Figma announced its own import and export of the format at Schema 2025, though at the time of writing it had not reached every account. A small private plugin could also save the variables in the REST API's shape, so the rest of the pipeline is the same on every plan.
- **Modes need a paid plan.** Figma's Starter plan allows one mode per collection, so it cannot hold light and dark in one collection.

## Keeping it honest

- **CI regenerates the tokens** and fails when the committed files differ, so generated code is never edited by hand.
- **The contrast test**, which already exists, checks WCAG AA contrast for every text and graphic pair in every mode. A designer can change any colour, and a pull request that makes text hard to read fails.
- **Widgetbook builds on every pull request**, so designers review the change in every mode before it merges.
- **A scheduled workflow** could pull the variables every morning, or when a relay forwards Figma's `LIBRARY_PUBLISH` webhook as a `repository_dispatch`, and open a pull request. A pull request opened with GitHub's default token does not start other workflows, so it needs a GitHub App or fine grained token for CI to run on it.

## Who owns what

| | Owned by | Changed in |
| --- | --- | --- |
| Token values and descriptions | Designers | Figma |
| New token groups, and renamed or removed tokens | Designers and developers | Figma, then code that used the old names |
| How Material's components use the tokens | Developers | `AppTheme` |
| Components | Designers design them, developers build them | Figma, then `core_design_system` |

Adding a token needs no code. Renaming or removing one changes a generated name, so the code using it stops compiling. That is useful, because the pull request shows every place affected, but a developer has to fix them.
