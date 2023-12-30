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
  bannerClicked('banner_clicked', true, true, true, true, true, false),
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

  static Future<void> appStarted({dynamic title, dynamic message}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    await EventLoggerContainer.logEvent(EventType.appStarted, attributes);
  }

  static Future<void> homePageEntered({dynamic abTestCase}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    await EventLoggerContainer.logEvent(EventType.homePageEntered, attributes);
  }

  static Future<void> appEnded() async {
    Map<String, dynamic> attributes = <String, dynamic>{};
    await EventLoggerContainer.logEvent(EventType.appEnded, attributes);
  }

  static Future<void> buttonClicked({dynamic abTestCase}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    await EventLoggerContainer.logEvent(EventType.buttonClicked, attributes);
  }

  static Future<void> selectContents(
      {dynamic contentType, dynamic itemId}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    await EventLoggerContainer.logEvent(EventType.selectContents, attributes);
  }

  static Future<void> sendMessage({dynamic title, dynamic message}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    await EventLoggerContainer.logEvent(EventType.sendMessage, attributes);
  }

  static Future<void> countIncreased({dynamic count}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    await EventLoggerContainer.logEvent(EventType.countIncreased, attributes);
  }

  static Future<void> bannerClicked() async {
    Map<String, dynamic> attributes = <String, dynamic>{};
    await EventLoggerContainer.logEvent(EventType.bannerClicked, attributes);
  }

  static Future<void> setUserId({dynamic id}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    await EventLoggerContainer.logEvent(EventType.setUserId, attributes);
  }

  static Future<void> setUserInfo({dynamic age, dynamic gender}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    await EventLoggerContainer.logEvent(EventType.setUserInfo, attributes);
  }

  static Future<void> purchase(
      {dynamic productId,
      dynamic price,
      dynamic currency,
      dynamic quantity}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'productId': productId,
      'price': price,
      'currency': currency,
      'quantity': quantity,
    };
    await EventLoggerContainer.logEvent(EventType.purchase, attributes);
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

  static Future<void> setup() async {
    await firebaseAnalyticsLogger.setup();
    await appsFlyerLogger.setup();
    await amplitudeLogger.setup();
    await mixpanelLogger.setup();
    await singularLogger.setup();
    await datadogDebugLogger.setup();
  }

  static Future<void> logEvent(
      EventType event, Map<String, dynamic> attributes) async {
    if (event.isFirebaseEnabled) {
      await firebaseAnalyticsLogger.logEvent(event.name,
          attributes: attributes);
    }
    if (event.isAppsFlyerEnabled) {
      await appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isAmplitudeEnabled) {
      await amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isMixpanelEnabled) {
      await mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isSingularEnabled) {
      await singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isDatadogEnabled) {
      await datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
