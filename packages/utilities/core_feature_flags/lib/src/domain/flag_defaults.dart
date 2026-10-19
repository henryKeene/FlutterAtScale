import 'package:core_config/core_config.dart';
import 'package:core_feature_flags/src/domain/models/feature_flag.dart';

Map<FeatureFlag, bool> flagDefaults(AppEnvironment environment) =>
    switch (environment) {
      AppEnvironment.development || AppEnvironment.staging => {
        for (final flag in FeatureFlag.values) flag: true,
      },
      AppEnvironment.production => const {
        FeatureFlag.readingStats: false,
        FeatureFlag.bookReviews: true,
        FeatureFlag.shelfGrid: false,
        FeatureFlag.trendingBooks: false,
      },
    };
