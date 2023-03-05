/// Annotation to enable analytics logger
class AnalyticsLogger {
  final String? localCsvPath;
  final String? remoteCsvPath;
  final bool? firebaseAnalytics;
  final bool? appsflyer;
  final bool? amplitude;
  final bool? mixpanel;
  final bool? singular;
  final bool? dataDog;

  const AnalyticsLogger({
    this.localCsvPath = '',
    this.remoteCsvPath = '',
    this.firebaseAnalytics = false,
    this.appsflyer = false,
    this.amplitude = false,
    this.mixpanel = false,
    this.singular = false,
    this.dataDog = false,
  });
}