import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://docs.google.com/spreadsheets/d/e/2PACX-1vSziB4YXy4C777tDDHlW96iT-640jWsfpc0cJLCc114DWxNusSQs61EkrY5lhLcp0T1Wkj1IJWijQ-j/pub?gid=0&single=true&output=csv',
    loggers: {
      FirebaseAnalyticsLogger: 'enableFirebase',
      AppsFlyerLogger: 'hasAppsFlyer',
      AmplitudeLogger: 'customizableName1',
      MixpanelLogger: 'customizableName2',
      SingularLogger: 'customizableName3',
      DatadogDebugLogger: 'customizableName4',
    },
    providerName: 'AnalyticsEventProviderB',
    eventTypeName: 'AnalyticsEventB')
// ignore: unused_element
class _IntegratedAnalyticsLoggerB {}
