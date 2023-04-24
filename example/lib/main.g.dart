// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum EventType {
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

  const EventType(
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

  static EventType fromName(String name) {
    switch (name) {
      case 'app_started':
        return EventType.appStarted;
      case 'home_page_entered':
        return EventType.homePageEntered;
      case 'app_ended':
        return EventType.appEnded;
      case 'button_clicked':
        return EventType.buttonClicked;
      case 'select_contents':
        return EventType.selectContents;
      case 'send_message':
        return EventType.sendMessage;
      case 'countIncreased':
        return EventType.countIncreased;
      case 'banner_clicked':
        return EventType.bannerClicked;
      case 'set_user_id':
        return EventType.setUserId;
      case 'set_user_info':
        return EventType.setUserInfo;
      case 'purchase':
        return EventType.purchase;
      default:
        throw ArgumentError('Invalid name: $name');
    }
  }
}

class EventProvider {
  EventProvider._();

  static void appStarted(
      {dynamic title, dynamic message, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    EventLoggerContainer.logEvent(EventType.appStarted, attributes,
        onComplete: onComplete);
  }

  static void homePageEntered({dynamic abTestCase, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    EventLoggerContainer.logEvent(EventType.homePageEntered, attributes,
        onComplete: onComplete);
  }

  static void appEnded({Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{};
    EventLoggerContainer.logEvent(EventType.appEnded, attributes,
        onComplete: onComplete);
  }

  static void buttonClicked({dynamic abTestCase, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    EventLoggerContainer.logEvent(EventType.buttonClicked, attributes,
        onComplete: onComplete);
  }

  static void selectContents(
      {dynamic contentType, dynamic itemId, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    EventLoggerContainer.logEvent(EventType.selectContents, attributes,
        onComplete: onComplete);
  }

  static void sendMessage(
      {dynamic title, dynamic message, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    EventLoggerContainer.logEvent(EventType.sendMessage, attributes,
        onComplete: onComplete);
  }

  static void countIncreased({dynamic count, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    EventLoggerContainer.logEvent(EventType.countIncreased, attributes,
        onComplete: onComplete);
  }

  static void bannerClicked({Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{};
    EventLoggerContainer.logEvent(EventType.bannerClicked, attributes,
        onComplete: onComplete);
  }

  static void setUserId({dynamic id, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    EventLoggerContainer.logEvent(EventType.setUserId, attributes,
        onComplete: onComplete);
  }

  static void setUserInfo({dynamic age, dynamic gender, Function? onComplete}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    EventLoggerContainer.logEvent(EventType.setUserInfo, attributes,
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
    EventLoggerContainer.logEvent(EventType.purchase, attributes,
        onComplete: onComplete);
  }
}

class EventLoggerContainer {
  EventLoggerContainer._();
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

  static void logEvent(EventType event, Map<String, dynamic> attributes,
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
