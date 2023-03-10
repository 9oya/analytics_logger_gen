import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_loggers.dart';

part 'analytics_logger_from_private_repo.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://api.github.com/repos/9oya/analytics_logger_gen_example_private_docs/contents/logger_gen_example_sheet.csv',
    httpHeaders: {
      'X-GitHub-Api-Version': '2022-11-28',
      'Accept': 'application/vnd.github.v3.raw',
      'Authorization': 'Bearer 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',
    },
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
