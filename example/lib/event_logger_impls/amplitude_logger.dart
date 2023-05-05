import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// ignore: depend_on_referenced_packages
import 'package:amplitude_flutter/amplitude.dart';

import '../main.dart';

class AmplitudeLogger extends EventLogger {
  AmplitudeLogger();

  final _analytics = Amplitude.getInstance(instanceName: "project");

  @override
  Future<void> setup() async {
    await _analytics.setUseDynamicConfig(true);
    await _analytics.setServerUrl("https://api2.amplitude.com");
    await _analytics.init("API_KEY");
    await _analytics.enableCoppaControl();
    await _analytics.setUserId("test_user", startNewSession: true);
    await _analytics.trackingSessionEvents(true);
    await _analytics.setMinTimeBetweenSessionsMillis(5000);
    await _analytics.setEventUploadThreshold(5);
    await _analytics.setEventUploadPeriodMillis(30000);
    await _analytics.setServerZone("US");
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
