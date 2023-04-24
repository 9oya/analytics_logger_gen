import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// ignore: depend_on_referenced_packages
// import 'package:firebase_core/firebase_core.dart';

// ignore: depend_on_referenced_packages
// import 'package:firebase_analytics/firebase_analytics.dart';

// import '../main.dart';

class FirebaseAnalyticsLogger extends EventLogger {
  FirebaseAnalyticsLogger();

  // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> setup() async {
    // await Firebase.initializeApp();
    super.setup();
  }

  @override
  void logEvent(String event,
      {required Map<String, dynamic> attributes, Function? onComplete}) async {
    // switch (EventType.fromName(event)) {
    //   case EventType.setUserId:
    //     await _analytics.setUserId(
    //         id: attributes.values.first?.value.toString());
    //     onComplete?.call();
    //     break;
    //   case EventType.setUserInfo:
    //     for (final entry in attributes.entries) {
    //       await _analytics.setUserProperty(
    //         name: entry.key,
    //         value: entry.value,
    //       );
    //     }
    //     onComplete?.call();
    //     break;
    //   default:
    //     await _analytics.logEvent(name: event, parameters: attributes);
    //     onComplete?.call();
    // }
  }
}
