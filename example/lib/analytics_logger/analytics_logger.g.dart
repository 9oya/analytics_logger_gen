// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
// app_started,
  appStarted('app_started', true, true, true, true, true, true),
// ,
// ,
// home_page_entered,
  homePageEntered('home_page_entered', true, true, true, true, true, true),
// ab_test_case,
// ,
// my_page_entered,
  myPageEntered('my_page_entered', true, true, true, true, true, true),
// ab_test_case,
// ,
// app_ended,
  appEnded('app_ended', true, true, true, true, true, true),
// ,
// ,
// home_bottom_button_clicked,
  homeBottomButtonClicked(
      'home_bottom_button_clicked', true, true, true, true, true, true),
// a, b, c, d,
// ,
// my_send_message_clicked,
  mySendMessageClicked(
      'my_send_message_clicked', true, true, true, true, true, true),
// title, message,
// ,
// home_banner_button_clicked,
  homeBannerButtonClicked(
      'home_banner_button_clicked', true, true, true, true, true, true),
  ;

// is_allowed,
// ,
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
