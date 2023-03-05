import 'package:analytics_logger_gen/analytics_logger_gen.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:singular_flutter_sdk/singular.dart';

part 'analytics_logger.g.dart';

@AnalyticsLogger(
  remoteCsvUrl:
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdNT_NP48M631T55KV2rrMlEYAIe2pZ7m-ATWvlwdWVUkf1k2wvbh9b8tNSYR56Q93RwWUMSXI1-p3/pub?output=csv',
  firebaseAnalytics: true,
  singular: true,
  dataDog: true,
)
// ignore: unused_element
class _CustomAnalyticsLogger {}

