/// The EventLogger interface wraps the underlying analytics SDKs for analytics event logging.
abstract class EventLogger {
  const EventLogger();

  void logEvent(String event,
      {required Map<String, dynamic> attributes, Function? onComplete});

  void setup() {}
}
