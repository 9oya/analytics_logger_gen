import 'package:analytics_logger_gen/analytics_logger_gen.dart';

class DatadogDebugLogger extends EventLogger {
  DatadogDebugLogger();

  @override
  Future<void> setup() {
    // TODO: implement setup
    return super.setup();
  }

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}
