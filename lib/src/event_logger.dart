/// The EventLogger interface wraps the underlying analytics SDKs for analytics event logging.
abstract class EventLogger {
  const EventLogger();

  /// Override this method to setup the analytics SDKs.
  Future<void> setup() async {}

  /// Override this method to log the event to the analytics SDKs.
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes});
}
