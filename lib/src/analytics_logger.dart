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
  ///    loggers: <Type, String>{
  ///       FirebaseAnalyticsLogger: 'isFirebaseEnabled',
  ///       AppsFlyerLogger: 'isAppsFlyerEnabled',
  ///       AmplitudeLogger: 'isAmplitudeEnabled',
  ///       MixpanelLogger: 'isMixpanelEnabled',
  ///       SingularLogger: 'isSingularEnabled',
  ///       DatadogDebugLogger: 'isDatadogEnabled',
  ///     },
  /// // ignore: unused_element
  /// class _EventLoggerContainer {}
  /// ```
  final Map<String, String> httpHeaders;

  /// You can add analytics event loggers to the loggers.
  /// - The [KEY] of the map is the [Type] of the class that implements the [EventLogger] interface.
  /// - The [VALUE] is the name of the column in the [CSV file].
  /// - The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [1] to enable the logger.
  /// - The value of the [COLUMN_NAME] in the CSV file should be [FALSE], [0] or [] to disable the logger.
  ///
  /// ```dart
  /// @AnalyticsLogger(
  ///     // ex) (from project root)assets/logger_gen_example_sheet.csv
  ///     localCsvPath: '<YOUR_PROJECT_ROOT/PATH_TO_CSV_FILE>',
  ///     // When you declare the localCsvPath, the remoteCsvUrl is ignored.
  ///     remoteCsvUrl: '<URL-TO-CSV-FILE>',
  ///
  ///     loggers: <Type, String>{
  ///       // The key of the map is the Type of the class that implements the [EventLogger] interface.
  ///       //
  ///       // Matching <CSV-COLUMN-NAME> in @AnalyticsLogger with CSV column determines which analytics tool to call for generated events.
  ///       FirebaseAnalyticsLogger: '<CSV-COLUMN-NAME>',
  ///     })
  /// class _EventLoggerContainer {}
  ///
  /// class FirebaseAnalyticsLogger extends EventLogger {
  ///   FirebaseAnalyticsLogger();
  ///
  ///   @override
  ///   void logEvent(String event, {required Map<String, dynamic> attributes}) {
  ///     // Do something with the event and attributes
  ///   }
  /// }
  /// ```
  final Map<Type, String> loggers;

  /// The [providerName] is used to generate the event provider class.
  final String providerName;

  /// The [eventTypeName] is used to generate the event type enum.
  final String eventTypeName;

  const AnalyticsLogger({
    this.localCsvPath = '',
    this.remoteCsvUrl = '',
    this.httpHeaders = const {},
    this.loggers = const {},
    this.providerName = 'EventProvider',
    this.eventTypeName = 'EventType',
  });
}
