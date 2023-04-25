/// The EventLogger interface wraps the underlying analytics SDKs for analytics event logging.
abstract class EventLogger {
  const EventLogger();

  Future<void> logEvent(String event, {required Map<String, dynamic> attributes});

  void setup() {}
}
