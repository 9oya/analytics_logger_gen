
abstract class EventLogger {

  const EventLogger();

  void logEvent(String event, {required Map<String, dynamic> attributes});
}