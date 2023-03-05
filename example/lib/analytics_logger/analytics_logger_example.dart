// GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:singular_flutter_sdk/singular.dart';

enum AnalyticsEvents {
  exampleEvent('example_event', true, true, true, true, true, true),
  exampleEvent2('example_event2', true, true, true, true, true, true);

  const AnalyticsEvents(this.name, this.hasFirebase, this.hasAppsflyer,
      this.hasAmplitude, this.hasMixpanel, this.hasSingular, this.hasDataDog);

  final String name;
  final bool hasFirebase;
  final bool hasAppsflyer;
  final bool hasAmplitude;
  final bool hasMixpanel;
  final bool hasSingular;
  final bool hasDataDog;
}

class AnalyticsEventsProvider {
  AnalyticsEventsProvider._();

  static void exampleEvent({String? param1, String? param2}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'param1': param1,
      'param2': param2,
    };
    CustomAnalyticsLogger.logEvent(AnalyticsEvents.exampleEvent, attributes);
  }
}

abstract class EventLogger {
  void logEvent(String event, {required Map<String, dynamic> attributes});
}

class FirebaseLogger implements EventLogger {
  FirebaseLogger({required this.firebase});

  final FirebaseAnalytics firebase;

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    firebase.logEvent(name: event, parameters: attributes);
  }
}

class SingularLogger implements EventLogger {
  SingularLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    Singular.eventWithArgs(event, attributes);
  }
}

class DataDogLogger implements EventLogger {
  DataDogLogger({required this.dataDog});

  final DatadogSdk dataDog;

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    dataDog.logs?.info(event, attributes: attributes.cast<String, String>());
  }
}

class CustomAnalyticsLogger {
  CustomAnalyticsLogger._();

  static final EventLogger firebaseLogger =
  FirebaseLogger(firebase: FirebaseAnalytics.instance);
  static final EventLogger singularLogger = SingularLogger();
  static final EventLogger dataDogLogger =
  DataDogLogger(dataDog: DatadogSdk.instance);

  static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {
    if (event.hasDataDog) {
      dataDogLogger.logEvent(event.name,
          attributes: attributes ?? <String, dynamic>{});
    }
    if (event.hasFirebase) {
      firebaseLogger.logEvent(event.name,
          attributes: attributes ?? <String, dynamic>{});
    }
    if (event.hasSingular) {
      singularLogger.logEvent(event.name,
          attributes: attributes ?? <String, dynamic>{});
    }
  }
}
