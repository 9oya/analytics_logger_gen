import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_local_file.g.dart';

@AnalyticsLogger(
    localCsvPath: 'assets/logger_gen_example_v2.csv',
    loggers: {
      FirebaseAnalyticsLogger: 'enableFirebase',
      AppsFlyerLogger: 'hasAppsFlyer',
      AmplitudeLogger: 'customizableName1',
      MixpanelLogger: 'customizableName2',
      SingularLogger: 'customizableName3',
      DatadogDebugLogger: 'customizableName4',
    },
    providerName: 'AnalyticsEventProviderC',
    eventTypeName: 'AnalyticsEventC')
// ignore: unused_element
class _IntegratedAnalyticsLoggerC {}
