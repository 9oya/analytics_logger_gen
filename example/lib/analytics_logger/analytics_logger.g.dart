// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
  appStarted('app_started', true, true),
  homePageEntered('home_page_entered', true, true),
  myPageEntered('my_page_entered', true, true),
  appEnded('app_ended', true, false),
  homeBottomButtonClicked('home_bottom_button_clicked', true, true),
  mySendMessageClicked('my_send_message_clicked', false, true),
  homeBannerButtonClicked('home_banner_button_clicked', true, true);

  const AnalyticsEvents(this.name, this.enableFirebase, this.hasDataDog);
  final String name;
  final bool enableFirebase;
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

class CustomAnalyticsLogger {
  CustomAnalyticsLogger._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
      const FirebaseAnalyticsLogger();
  static DatadogDebugLogger datadogDebugLogger = const DatadogDebugLogger();
  static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {
    if (event.enableFirebase) {
      firebaseAnalyticsLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasDataDog) {
      datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
