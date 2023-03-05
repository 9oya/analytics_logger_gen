import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'analytics_logger_gen_platform_interface.dart';

/// An implementation of [AnalyticsLoggerGenPlatform] that uses method channels.
class MethodChannelAnalyticsLoggerGen extends AnalyticsLoggerGenPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('analytics_logger_gen');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
