import 'dart:io';

import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_loggers.dart';

part 'analytics_logger_from_local_file.g.dart';

@AnalyticsLogger(localCsvPath: 'assets/logger_gen_example_sheet.csv', loggers: {
  'enableFirebase': FirebaseAnalyticsLogger(),
  'hasAppsFlyer': AppsFlyerLogger(),
  'customColumnName1': AmplitudeLogger(),
  'customColumnName2': MixpanelLogger(),
  'customColumnName3': SingularLogger(),
  'customColumnName4': DatadogDebugLogger(),
})
// ignore: unused_element
class _CustomAnalyticsLoggerC {}
