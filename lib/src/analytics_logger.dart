import 'package:analytics_logger_gen/analytics_logger_gen.dart';

/// Annotation to generate analytics logger
class AnalyticsLogger {
  /// When [localCsvPath] is provided, the logger and events will be
  /// generated from the local CSV file.
  /// (When you declare the localCsvPath, the remoteCsvUrl is ignored.)
  final String localCsvPath;

  /// When [remoteCsvUrl] is provided, the logger and events will be
  /// generated from the remote CSV file.
  final String remoteCsvUrl;

  /// You can add HTTP headers to the request for the remote CSV file.
  /// ```dart
  /// @AnalyticsLogger(
  ///     remoteCsvUrl:
  ///         'https://api.github.com/repos/[OWNER]/[REPO]/contents/[PATH]',
  ///     httpHeaders: {
  ///       'X-GitHub-Api-Version': '2022-11-28',
  ///       'Accept': 'application/vnd.github.v3.raw',
  ///       'Authorization': 'Bearer [YOUR-TOKEN]',
  ///     },
  ///     loggers: {
  ///       'enableFirebase': FirebaseAnalyticsLogger(),
  ///       'hasAppsFlyer': AppsFlyerLogger(),
  ///       'customColumnName1': AmplitudeLogger(),
  ///       'customColumnName2': MixpanelLogger(),
  ///       'customColumnName3': SingularLogger(),
  ///       'customColumnName4': DatadogDebugLogger(),
  ///     })
  /// // ignore: unused_element
  /// class _CustomAnalyticsLogger {}
  /// ```
  final Map<String, String> httpHeaders;

  /// You can add analytics event loggers to the loggers.
  /// - The [KEY] is the name of the column in the [CSV file]
  /// - The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [FALSE]
  ///
  /// ```dart
  /// @AnalyticsLogger(
  ///     localCsvPath: '<YOUR_PROJECT_ROOT/PATH_TO_CSV_FILE>',
  ///     loggers: {
  ///       // COLUMN_NAME is the name of the column in the CSV file
  ///       // The value of the COLUMN_NAME should be 'TRUE' or 'FALSE'
  ///       '[COLUMN_NAME]': FirebaseAnalyticsLogger(),
  ///     })
  /// class _CustomAnalyticsLogger {}
  ///
  /// class FirebaseAnalyticsLogger extends EventLogger {
  ///   const SomeAnalyticsLogger();
  ///
  ///   @override
  ///   void logEvent(String event, {required Map<String, dynamic> attributes}) {
  ///     // Do something with the event and attributes
  ///   }
  /// }
  /// ```
  final Map<String, EventLogger> loggers;

  const AnalyticsLogger({
    this.localCsvPath = '',
    this.remoteCsvUrl = '',
    this.httpHeaders = const {},
    this.loggers = const {},
  });
}
