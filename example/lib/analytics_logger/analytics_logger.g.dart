// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
  appStarted('app_started', true, true, true, true, true, true),
  homePageEntered('home_page_entered', true, true, true, true, true, true),
  myPageEntered('my_page_entered', true, true, true, true, true, true),
  appEnded('app_ended', true, true, true, true, true, true),
  homeBottomButtonClicked(
      'home_bottom_button_clicked', true, true, true, true, true, true),
  mySendMessageClicked(
      'my_send_message_clicked', true, true, true, true, true, true),
  homeBannerButtonClicked(
      'home_banner_button_clicked', true, true, true, true, true, true);

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

abstract class EventLogger {}

class FirebaseLogger extends EventLogger {}

class AppsFlyerLogger extends EventLogger {}

class AmplitudeLogger extends EventLogger {}

class MixpanelLogger extends EventLogger {}

class SingularLogger extends EventLogger {}

class DataDogLogger extends EventLogger {}

class CustomAnalyticsLogger {}
