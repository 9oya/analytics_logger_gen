
import 'package:analytics_logger_gen/analytics_logger_gen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsLogger extends BaseLogger {

  const FirebaseAnalyticsLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    FirebaseAnalytics.instance.logEvent(name: event, parameters: attributes);
  }
}