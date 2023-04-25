import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// ignore: depend_on_referenced_packages
import 'package:amplitude_flutter/amplitude.dart';

import '../main.dart';

class AmplitudeLogger extends EventLogger {
  AmplitudeLogger();

  final _analytics = Amplitude.getInstance(instanceName: "project");

  @override
  void setup() {
    _analytics.setUseDynamicConfig(true);
    _analytics.setServerUrl("https://api2.amplitude.com");
    _analytics.init("API_KEY");
    _analytics.enableCoppaControl();
    _analytics.setUserId("test_user", startNewSession: true);
    _analytics.trackingSessionEvents(true);
    _analytics.setMinTimeBetweenSessionsMillis(5000);
    _analytics.setEventUploadThreshold(5);
    _analytics.setEventUploadPeriodMillis(30000);
    _analytics.setServerZone("US");
  }

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
    switch (EventType.fromName(event)) {
      case EventType.setUserId:
        await _analytics.setUserId(attributes.values.first?.value.toString());
        break;
      case EventType.setUserInfo:
        await _analytics.setUserProperties(attributes);
        break;
      default:
        await _analytics.logEvent(event, eventProperties: attributes);
    }
  }
}
