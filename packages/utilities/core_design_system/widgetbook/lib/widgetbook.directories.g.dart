// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:core_design_system_widgetbook/components/book_cover.dart'
    as _core_design_system_widgetbook_components_book_cover;
import 'package:core_design_system_widgetbook/components/book_list_tile.dart'
    as _core_design_system_widgetbook_components_book_list_tile;
import 'package:core_design_system_widgetbook/components/feedback.dart'
    as _core_design_system_widgetbook_components_feedback;
import 'package:core_design_system_widgetbook/components/rating_stars.dart'
    as _core_design_system_widgetbook_components_rating_stars;
import 'package:core_design_system_widgetbook/tokens/color_tokens.dart'
    as _core_design_system_widgetbook_tokens_color_tokens;
import 'package:core_design_system_widgetbook/tokens/dimension_tokens.dart'
    as _core_design_system_widgetbook_tokens_dimension_tokens;
import 'package:core_design_system_widgetbook/tokens/typography_tokens.dart'
    as _core_design_system_widgetbook_tokens_typography_tokens;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Components',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'BookCover',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'From Open Library',
            builder: _core_design_system_widgetbook_components_book_cover
                .bookCoverNetwork,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'No cover',
            builder: _core_design_system_widgetbook_components_book_cover
                .bookCoverPlaceholder,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'BookListTile',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _core_design_system_widgetbook_components_book_list_tile
                .bookListTile,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Long title',
            builder: _core_design_system_widgetbook_components_book_list_tile
                .bookListTileLongTitle,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'EmptyState',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _core_design_system_widgetbook_components_feedback.emptyState,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'ErrorView',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _core_design_system_widgetbook_components_feedback.errorView,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'LoadingIndicator',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _core_design_system_widgetbook_components_feedback
                .loadingIndicator,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'RatingStars',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Interactive',
            builder: _core_design_system_widgetbook_components_rating_stars
                .ratingStarsInteractive,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Read only',
            builder: _core_design_system_widgetbook_components_rating_stars
                .ratingStars,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'SectionHeader',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _core_design_system_widgetbook_components_feedback
                .sectionHeader,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'Tag',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Tones',
            builder: _core_design_system_widgetbook_components_feedback.tags,
          ),
        ],
      ),
    ],
  ),
  _widgetbook.WidgetbookCategory(
    name: 'Tokens',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ColorTokens',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'All',
            builder:
                _core_design_system_widgetbook_tokens_color_tokens.colorTokens,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'DimensionTokens',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Radius',
            builder: _core_design_system_widgetbook_tokens_dimension_tokens
                .radiusTokens,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Size',
            builder: _core_design_system_widgetbook_tokens_dimension_tokens
                .sizeTokens,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Spacing',
            builder: _core_design_system_widgetbook_tokens_dimension_tokens
                .spacingTokens,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TypographyTokens',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'All',
            builder: _core_design_system_widgetbook_tokens_typography_tokens
                .typographyTokens,
          ),
        ],
      ),
    ],
  ),
];
