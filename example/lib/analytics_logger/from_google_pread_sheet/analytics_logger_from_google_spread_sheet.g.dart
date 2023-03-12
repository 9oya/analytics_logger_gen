// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger_from_google_spread_sheet.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
  appStarted('app_started', true, true, true, true, true, true),
  homePageEntered('home_page_entered', true, true, true, true, false, true),
  myPageEntered('my_page_entered', true, true, true, true, true, true),
  appEnded('app_ended', true, true, true, true, true, false),
  homeBottomButtonClicked(
      'home_bottom_button_clicked', true, true, true, true, true, true),
  selectContents('select_contents', true, false, false, false, false, false),
  mySendMessageClicked(
      'my_send_message_clicked', false, true, true, true, false, true),
  homeBannerButtonClicked(
      'home_banner_button_clicked', true, true, true, true, true, true);

  const AnalyticsEvents(
      this.name,
      this.enableFirebase,
      this.hasAppsFlyer,
      this.customColumnName1,
      this.customColumnName2,
      this.customColumnName3,
      this.customColumnName4);
  final String name;
  final bool enableFirebase;
  final bool hasAppsFlyer;
  final bool customColumnName1;
  final bool customColumnName2;
  final bool customColumnName3;
  final bool customColumnName4;
}

class AnalyticsEventsProvider {
  AnalyticsEventsProvider._();
  static void appStarted() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.appStarted, attributes);
  }

  static void homePageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homePageEntered, attributes);
  }

  static void myPageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.myPageEntered, attributes);
  }

  static void appEnded() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.appEnded, attributes);
  }

  static void homeBottomButtonClicked(
      {dynamic a, dynamic b, dynamic c, dynamic d}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
      'd': d,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homeBottomButtonClicked, attributes);
  }

  static void selectContents({dynamic contentType, dynamic itemId}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.selectContents, attributes);
  }

  static void mySendMessageClicked({dynamic title, dynamic message}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.mySendMessageClicked, attributes);
  }

  static void homeBannerButtonClicked({dynamic isAllowed}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'isAllowed': isAllowed,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homeBannerButtonClicked, attributes);
  }
}

class CustomAnalyticsLoggerA {
  CustomAnalyticsLoggerA._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
      const FirebaseAnalyticsLogger();
  static AppsFlyerLogger appsFlyerLogger = const AppsFlyerLogger();
  static AmplitudeLogger amplitudeLogger = const AmplitudeLogger();
  static MixpanelLogger mixpanelLogger = const MixpanelLogger();
  static SingularLogger singularLogger = const SingularLogger();
  static DatadogDebugLogger datadogDebugLogger = const DatadogDebugLogger();
  static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {
    if (event.enableFirebase) {
      firebaseAnalyticsLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasAppsFlyer) {
      appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName1) {
      amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName2) {
      mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName3) {
      singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName4) {
      datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
