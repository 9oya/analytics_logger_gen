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

class AnalyticsEventsProvider {}

abstract class EventLogger {}

class FirebaseLogger extends EventLogger {}

class AppsFlyerLogger extends EventLogger {}

class AmplitudeLogger extends EventLogger {}

class MixpanelLogger extends EventLogger {}

class SingularLogger extends EventLogger {}

class DataDogLogger extends EventLogger {}

class CustomAnalyticsLogger {}
