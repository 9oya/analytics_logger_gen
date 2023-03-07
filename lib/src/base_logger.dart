
abstract class BaseLogger {

  const BaseLogger();

  void logEvent(String event, {required Map<String, dynamic> attributes});
}