import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'analytics_logger_gen_method_channel.dart';

abstract class AnalyticsLoggerGenPlatform extends PlatformInterface {
  /// Constructs a AnalyticsLoggerGenPlatform.
  AnalyticsLoggerGenPlatform() : super(token: _token);

  static final Object _token = Object();

  static AnalyticsLoggerGenPlatform _instance = MethodChannelAnalyticsLoggerGen();

  /// The default instance of [AnalyticsLoggerGenPlatform] to use.
  ///
  /// Defaults to [MethodChannelAnalyticsLoggerGen].
  static AnalyticsLoggerGenPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AnalyticsLoggerGenPlatform] when
  /// they register themselves.
  static set instance(AnalyticsLoggerGenPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
