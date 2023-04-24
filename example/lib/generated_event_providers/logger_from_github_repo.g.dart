// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_from_github_repo.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum EventTypeA {
  appStarted('app_started', true, true, true, true, true, true),
  homePageEntered('home_page_entered', true, true, true, true, false, true),
  appEnded('app_ended', true, true, true, true, true, false),
  buttonClicked('button_clicked', true, true, true, true, true, true),
  selectContents('select_contents', true, false, false, false, false, false),
  sendMessage('send_message', false, true, true, true, false, true),
  countIncreased('countIncreased', true, true, true, true, true, true),
  bannerClicked('banner_clicked', true, true, true, true, true, true),
  setUserId('set_user_id', true, false, false, false, false, false),
  setUserInfo('set_user_info', true, false, false, false, false, false),
  purchase('purchase', true, false, false, false, false, false);

  const EventTypeA(
      this.name,
      this.isFirebaseEnabled,
      this.isAppsFlyerEnabled,
      this.isAmplitudeEnabled,
      this.isMixpanelEnabled,
      this.isSingularEnabled,
      this.isDatadogEnabled);
  final String name;
  final bool isFirebaseEnabled;
  final bool isAppsFlyerEnabled;
  final bool isAmplitudeEnabled;
  final bool isMixpanelEnabled;
  final bool isSingularEnabled;
  final bool isDatadogEnabled;

  static EventTypeA fromName(String name) {
    switch (name) {
      case 'app_started':
        return EventTypeA.appStarted;
      case 'home_page_entered':
        return EventTypeA.homePageEntered;
      case 'app_ended':
        return EventTypeA.appEnded;
      case 'button_clicked':
        return EventTypeA.buttonClicked;
      case 'select_contents':
        return EventTypeA.selectContents;
      case 'send_message':
        return EventTypeA.sendMessage;
      case 'countIncreased':
        return EventTypeA.countIncreased;
      case 'banner_clicked':
        return EventTypeA.bannerClicked;
      case 'set_user_id':
        return EventTypeA.setUserId;
      case 'set_user_info':
        return EventTypeA.setUserInfo;
      case 'purchase':
        return EventTypeA.purchase;
      default:
        throw ArgumentError('Invalid name: $name');
    }
  }
}

class EventProviderA {
  EventProviderA._();

  static void appStarted(
      {dynamic title, dynamic message, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    EventLoggerContainerA.logEvent(EventTypeA.appStarted, attributes,
        onComplete: onComplete);
  }

  static void homePageEntered({dynamic abTestCase, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    EventLoggerContainerA.logEvent(EventTypeA.homePageEntered, attributes,
        onComplete: onComplete);
  }

  static void appEnded({Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{};
    EventLoggerContainerA.logEvent(EventTypeA.appEnded, attributes,
        onComplete: onComplete);
  }

  static void buttonClicked({dynamic abTestCase, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    EventLoggerContainerA.logEvent(EventTypeA.buttonClicked, attributes,
        onComplete: onComplete);
  }

  static void selectContents(
      {dynamic contentType, dynamic itemId, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    EventLoggerContainerA.logEvent(EventTypeA.selectContents, attributes,
        onComplete: onComplete);
  }

  static void sendMessage(
      {dynamic title, dynamic message, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    EventLoggerContainerA.logEvent(EventTypeA.sendMessage, attributes,
        onComplete: onComplete);
  }

  static void countIncreased({dynamic count, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    EventLoggerContainerA.logEvent(EventTypeA.countIncreased, attributes,
        onComplete: onComplete);
  }

  static void bannerClicked({Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{};
    EventLoggerContainerA.logEvent(EventTypeA.bannerClicked, attributes,
        onComplete: onComplete);
  }

  static void setUserId({dynamic id, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    EventLoggerContainerA.logEvent(EventTypeA.setUserId, attributes,
        onComplete: onComplete);
  }

  static void setUserInfo({dynamic age, dynamic gender, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    EventLoggerContainerA.logEvent(EventTypeA.setUserInfo, attributes,
        onComplete: onComplete);
  }

  static void purchase(
      {dynamic productId,
      dynamic price,
      dynamic currency,
      dynamic quantity,
      Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'productId': productId,
      'price': price,
      'currency': currency,
      'quantity': quantity,
    };
    EventLoggerContainerA.logEvent(EventTypeA.purchase, attributes,
        onComplete: onComplete);
  }
}

class EventLoggerContainerA {
  EventLoggerContainerA._();
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

  static void logEvent(EventTypeA event, Map<String, dynamic> attributes,
      {Function? onComplete}) {
    if (event.isFirebaseEnabled) {
      firebaseAnalyticsLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
    if (event.isAppsFlyerEnabled) {
      appsFlyerLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
    if (event.isAmplitudeEnabled) {
      amplitudeLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
    if (event.isMixpanelEnabled) {
      mixpanelLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
    if (event.isSingularEnabled) {
      singularLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
    if (event.isDatadogEnabled) {
      datadogDebugLogger.logEvent(event.name,
          attributes: attributes, onComplete: onComplete);
    }
  }
}
