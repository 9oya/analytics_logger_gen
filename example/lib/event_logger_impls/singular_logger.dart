import 'package:analytics_logger_gen/analytics_logger_gen.dart';

class SingularLogger extends EventLogger {
  SingularLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}