import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import 'datadog_debug_logger.dart';
import 'firebase_analytics_logger.dart';

part 'analytics_logger.g.dart';

@AnalyticsLogger(
  remoteCsvUrl:
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdNT_NP48M631T55KV2rrMlEYAIe2pZ7m-ATWvlwdWVUkf1k2wvbh9b8tNSYR56Q93RwWUMSXI1-p3/pub?output=csv',
  loggers: {
    'enableFirebase': FirebaseAnalyticsLogger(),
    'hasDataDog': DatadogDebugLogger(),
  }
)
// ignore: unused_element
class _CustomAnalyticsLogger {}

