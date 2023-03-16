import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/analytics_logger_generator.dart';

Builder analyticsLoggerGenerator(BuilderOptions options) =>
    SharedPartBuilder([AnalyticsLoggerGenerator()], 'analytics_logger_gen');
