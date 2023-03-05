import 'package:analytics_logger_gen/analytics_logger_gen.dart';

part 'analytics_logger.g.dart';

@AnalyticsLogger(
  remoteCsvPath:
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdNT_NP48M631T55KV2rrMlEYAIe2pZ7m-ATWvlwdWVUkf1k2wvbh9b8tNSYR56Q93RwWUMSXI1-p3/pub?output=csv',
  firebaseAnalytics: true,
  appsflyer: true,
  amplitude: true,
  mixpanel: true,
  singular: true,
  dataDog: true,
)
class _CustomAnalyticsLogger {}

