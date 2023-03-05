// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
// app_started,
  app_started,
// ,
// ,
// home_page_entered,
  home_page_entered,
// ab_test_case,
// ,
// my_page_entered,
  my_page_entered,
// ab_test_case,
// ,
// app_ended,
  app_ended,
// ,
// ,
// home_bottom_button_clicked,
  home_bottom_button_clicked,
// a, b, c, d,
// ,
// my_send_message_clicked,
  my_send_message_clicked,
// title, message,
// ,
// home_banner_button_clicked,
  home_banner_button_clicked,
// is_allowed,
// ,
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
