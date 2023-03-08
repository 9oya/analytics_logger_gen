
import 'package:analytics_logger_gen/analytics_logger_gen.dart';
import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';

class DatadogDebugLogger extends EventLogger {

  const DatadogDebugLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    DatadogSdk.instance.logs?.debug(event, attributes: attributes);
  }
}