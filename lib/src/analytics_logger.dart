/// Annotation to generate analytics logger
class AnalyticsLogger {
  final String remoteCsvUrl;
  final bool hasFirebaseAnalytics;
  // TODO(eido9oy): Add support for other analytics providers
  // final bool appsflyer;
  // final bool amplitude;
  // final bool mixpanel;
  final bool hasSingular;
  final bool hasDataDog;

  const AnalyticsLogger({
    this.remoteCsvUrl = '',
    this.hasFirebaseAnalytics = false,
    // TODO(eido9oy): Add support for other analytics providers
    // this.appsflyer = false,
    // this.amplitude = false,
    // this.mixpanel = false,
    this.hasSingular = false,
    this.hasDataDog = false,
  });
}
