import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_loggers.dart';

part 'analytics_logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://docs.google.com/spreadsheets/d/e/2PACX-1vSwehSB_tVWzgaeVowghmaRODQdeGvriangiPy7C1ZzDcxq_j1GD7WhTH4HAlMeGTE3fs-ZZ84R45Jw/pub?gid=0&single=true&output=csv',
    loggers: {
      'enableFirebase': FirebaseAnalyticsLogger(),
      'hasAppsFlyer': AppsFlyerLogger(),
      'customColumnName1': AmplitudeLogger(),
      'customColumnName2': MixpanelLogger(),
      'customColumnName3': SingularLogger(),
      'customColumnName4': DatadogDebugLogger(),
    })
// ignore: unused_element
class _CustomAnalyticsLogger {}
