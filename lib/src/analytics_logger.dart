/// Annotation to generate analytics logger
class AnalyticsLogger {
  final String remoteCsvUrl;
  final bool firebaseAnalytics;
  // final bool appsflyer;
  // final bool amplitude;
  // final bool mixpanel;
  final bool singular;
  final bool dataDog;

  const AnalyticsLogger({
    this.remoteCsvUrl = '',
    this.firebaseAnalytics = false,
    // this.appsflyer = false,
    // this.amplitude = false,
    // this.mixpanel = false,
    this.singular = false,
    this.dataDog = false,
  });
}
