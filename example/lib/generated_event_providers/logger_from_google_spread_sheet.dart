import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://docs.google.com/spreadsheets/d/e/2PACX-1vSziB4YXy4C777tDDHlW96iT-640jWsfpc0cJLCc114DWxNusSQs61EkrY5lhLcp0T1Wkj1IJWijQ-j/pub?gid=0&single=true&output=csv',
    loggers: {
      FirebaseAnalyticsLogger: 'isFirebaseEnabled',
      AppsFlyerLogger: 'isAppsFlyerEnabled',
      AmplitudeLogger: 'isAmplitudeEnabled',
      MixpanelLogger: 'isMixpanelEnabled',
      SingularLogger: 'isSingularEnabled',
      DatadogDebugLogger: 'isDatadogEnabled',
    },
    providerName: 'EventProviderB',
    eventTypeName: 'EventTypeB')
// ignore: unused_element
class _EventLoggerContainerB {}
