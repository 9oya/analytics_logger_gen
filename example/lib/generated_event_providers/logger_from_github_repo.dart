import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_github_repo.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://raw.githubusercontent.com/9oya/analytics_logger_gen_example_public_docs-/main/logger_gen_example_v2.csv',
    loggers: {
      FirebaseAnalyticsLogger: 'enableFirebase',
      AppsFlyerLogger: 'hasAppsFlyer',
      AmplitudeLogger: 'customizableName1',
      MixpanelLogger: 'customizableName2',
      SingularLogger: 'customizableName3',
      DatadogDebugLogger: 'customizableName4',
    },
    providerName: 'AnalyticsEventProviderA',
    eventTypeName: 'AnalyticsEventA')
// ignore: unused_element
class _IntegratedAnalyticsLoggerA {}
