
import 'analytics_logger_gen_platform_interface.dart';

class AnalyticsLoggerGen {
  Future<String?> getPlatformVersion() {
    return AnalyticsLoggerGenPlatform.instance.getPlatformVersion();
  }
}
