// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
  appStarted('app_started', true, true, true),
  homePageEntered('home_page_entered', true, false, true),
  myPageEntered('my_page_entered', true, true, true),
  appEnded('app_ended', true, true, false),
  homeBottomButtonClicked('home_bottom_button_clicked', true, true, true),
  mySendMessageClicked('my_send_message_clicked', false, false, true),
  homeBannerButtonClicked('home_banner_button_clicked', true, true, true);

  const AnalyticsEvents(
      this.name, this.hasFirebase, this.hasSingular, this.hasDataDog);
  final String name;
  final bool hasFirebase;
  final bool hasSingular;
  final bool hasDataDog;
}

class AnalyticsEventsProvider {
  AnalyticsEventsProvider._();
  static void appStarted() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLogger.logEvent(AnalyticsEvents.appStarted, attributes);
  }

  static void homePageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLogger.logEvent(AnalyticsEvents.homePageEntered, attributes);
  }

  static void myPageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLogger.logEvent(AnalyticsEvents.myPageEntered, attributes);
  }

  static void appEnded() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLogger.logEvent(AnalyticsEvents.appEnded, attributes);
  }

  static void homeBottomButtonClicked(
      {dynamic a, dynamic b, dynamic c, dynamic d}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
      'd': d,
    };
    CustomAnalyticsLogger.logEvent(
        AnalyticsEvents.homeBottomButtonClicked, attributes);
  }

  static void mySendMessageClicked({dynamic title, dynamic message}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    CustomAnalyticsLogger.logEvent(
        AnalyticsEvents.mySendMessageClicked, attributes);
  }

  static void homeBannerButtonClicked({dynamic isAllowed}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'isAllowed': isAllowed,
    };
    CustomAnalyticsLogger.logEvent(
        AnalyticsEvents.homeBannerButtonClicked, attributes);
  }
}

abstract class EventLogger {
  void logEvent(String event, {required Map<String, dynamic> attributes});
}

class FirebaseLogger extends EventLogger {
  FirebaseLogger({required this.firebase});
  final FirebaseAnalytics firebase;
  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    firebase.logEvent(name: event, parameters: attributes);
  }
}

class SingularLogger extends EventLogger {
  SingularLogger();
  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    Singular.eventWithArgs(event, attributes);
  }
}

class DataDogLogger extends EventLogger {
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
    if (event.hasFirebase) {
      firebaseLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasSingular) {
      singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasDataDog) {
      dataDogLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
