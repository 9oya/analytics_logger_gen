// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_from_github_repo.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEventA {
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
      'home_banner_button_clicked', true, true, true, true, true, true),
  setUserId('set_user_id', true, false, false, false, false, false),
  setUserInfo('set_user_info', true, false, false, false, false, false),
  countIncreased('count_increased', true, true, false, false, false, false);

  const AnalyticsEventA(
      this.name,
      this.enableFirebase,
      this.hasAppsFlyer,
      this.customizableName1,
      this.customizableName2,
      this.customizableName3,
      this.customizableName4);
  final String name;
  final bool enableFirebase;
  final bool hasAppsFlyer;
  final bool customizableName1;
  final bool customizableName2;
  final bool customizableName3;
  final bool customizableName4;

  static AnalyticsEventA fromName(String name) {
    switch (name) {
      case 'app_started':
        return AnalyticsEventA.appStarted;
      case 'home_page_entered':
        return AnalyticsEventA.homePageEntered;
      case 'my_page_entered':
        return AnalyticsEventA.myPageEntered;
      case 'app_ended':
        return AnalyticsEventA.appEnded;
      case 'home_bottom_button_clicked':
        return AnalyticsEventA.homeBottomButtonClicked;
      case 'select_contents':
        return AnalyticsEventA.selectContents;
      case 'my_send_message_clicked':
        return AnalyticsEventA.mySendMessageClicked;
      case 'home_banner_button_clicked':
        return AnalyticsEventA.homeBannerButtonClicked;
      case 'set_user_id':
        return AnalyticsEventA.setUserId;
      case 'set_user_info':
        return AnalyticsEventA.setUserInfo;
      case 'count_increased':
        return AnalyticsEventA.countIncreased;
      default:
        throw ArgumentError('Invalid name: $name');
    }
  }
}

class AnalyticsEventProviderA {
  AnalyticsEventProviderA._();
  static void appStarted() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    IntegratedAnalyticsLoggerA.logEvent(AnalyticsEventA.appStarted, attributes);
  }

  static void homePageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.homePageEntered, attributes);
  }

  static void myPageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.myPageEntered, attributes);
  }

  static void appEnded() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    IntegratedAnalyticsLoggerA.logEvent(AnalyticsEventA.appEnded, attributes);
  }

  static void homeBottomButtonClicked(
      {dynamic a, dynamic b, dynamic c, dynamic d}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
      'd': d,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.homeBottomButtonClicked, attributes);
  }

  static void selectContents({dynamic contentType, dynamic itemId}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.selectContents, attributes);
  }

  static void mySendMessageClicked({dynamic title, dynamic message}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.mySendMessageClicked, attributes);
  }

  static void homeBannerButtonClicked({dynamic isAllowed}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'isAllowed': isAllowed,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.homeBannerButtonClicked, attributes);
  }

  static void setUserId({dynamic id}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    IntegratedAnalyticsLoggerA.logEvent(AnalyticsEventA.setUserId, attributes);
  }

  static void setUserInfo({dynamic age, dynamic gender}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.setUserInfo, attributes);
  }

  static void countIncreased({dynamic count}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    IntegratedAnalyticsLoggerA.logEvent(
        AnalyticsEventA.countIncreased, attributes);
  }
}

class IntegratedAnalyticsLoggerA {
  IntegratedAnalyticsLoggerA._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
      FirebaseAnalyticsLogger();
  static AppsFlyerLogger appsFlyerLogger = AppsFlyerLogger();
  static AmplitudeLogger amplitudeLogger = AmplitudeLogger();
  static MixpanelLogger mixpanelLogger = MixpanelLogger();
  static SingularLogger singularLogger = SingularLogger();
  static DatadogDebugLogger datadogDebugLogger = DatadogDebugLogger();
  static void setup() {
    firebaseAnalyticsLogger.setup();
    appsFlyerLogger.setup();
    amplitudeLogger.setup();
    mixpanelLogger.setup();
    singularLogger.setup();
    datadogDebugLogger.setup();
  }

  static void logEvent(AnalyticsEventA event, Map<String, dynamic> attributes) {
    if (event.enableFirebase) {
      firebaseAnalyticsLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasAppsFlyer) {
      appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName1) {
      amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName2) {
      mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName3) {
      singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName4) {
      datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
