
/// The [AnalyticsLogger] annotation is used to generate the logger class.
class AnalyticsLogger {
  /// When [localCsvPath] is provided, the logger and events will be
  /// generated from the local CSV file.
  ///
  /// example: (from project root)assets/logger_gen_example_sheet.csv
  ///
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
  ///    loggers: {
  ///      FirebaseAnalyticsLogger: 'enableFirebase',
  ///      AppsFlyerLogger: 'hasAppsFlyer',
  ///      AmplitudeLogger: 'customizableName1',
  ///      MixpanelLogger: 'customizableName2',
  ///      SingularLogger: 'customizableName3',
  ///      DatadogDebugLogger: 'customizableName4',
  ///    },
  /// // ignore: unused_element
  /// class _CustomAnalyticsLogger {}
  /// ```
  final Map<String, String> httpHeaders;

  /// You can add analytics event loggers to the loggers.
  /// - The [KEY] is the name of the logger class.
  /// - The [VALUE] is the name of the column in the [CSV file].
  /// - The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [1] to enable the logger.
  /// - The value of the [COLUMN_NAME] in the CSV file should be [FALSE], [0] or [NULL] to disable the logger.
  ///
  /// ```dart
  /// @AnalyticsLogger(
  ///     localCsvPath: '<YOUR_PROJECT_ROOT/PATH_TO_CSV_FILE>',
  ///     loggers: {
  ///       // COLUMN_NAME is the name of the column in the CSV file
  ///       // The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [1] to enable the logger.
  ///       // The value of the [COLUMN_NAME] in the CSV file should be [FALSE], [0] or [NULL] to disable the logger.
  ///       FirebaseAnalyticsLogger: '[COLUMN_NAME]',
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
  final Map<Type, String> loggers;

  final String providerName;

  final String eventTypeName;

  const AnalyticsLogger({
    this.localCsvPath = '',
    this.remoteCsvUrl = '',
    this.httpHeaders = const {},
    this.loggers = const {},
    this.providerName = 'AnalyticsEventProvider',
    this.eventTypeName = 'AnalyticsEvent',
  });
}
