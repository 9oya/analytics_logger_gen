import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_local_file.g.dart';

@AnalyticsLogger(
    localCsvPath: 'assets/logger_gen_example_v3.csv',
    loggers: {
          FirebaseAnalyticsLogger: 'isFirebaseEnabled',
          AppsFlyerLogger: 'isAppsFlyerEnabled',
          AmplitudeLogger: 'isAmplitudeEnabled',
          MixpanelLogger: 'isMixpanelEnabled',
          SingularLogger: 'isSingularEnabled',
          DatadogDebugLogger: 'isDatadogEnabled',
    },
    providerName: 'EventProviderC',
    eventTypeName: 'EventTypeC')
// ignore: unused_element
class _CommonEventLoggerC {}
