import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_github_repo.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://raw.githubusercontent.com/9oya/analytics_logger_gen_example_public_docs-/main/logger_gen_example_v3.csv',
    loggers: {
      FirebaseAnalyticsLogger: 'isFirebaseEnabled',
      AppsFlyerLogger: 'isAppsFlyerEnabled',
      AmplitudeLogger: 'isAmplitudeEnabled',
      MixpanelLogger: 'isMixpanelEnabled',
      SingularLogger: 'isSingularEnabled',
      DatadogDebugLogger: 'isDatadogEnabled',
    },
    providerName: 'EventProviderA',
    eventTypeName: 'EventTypeA')
// ignore: unused_element
class _EventLoggerContainerA {}
