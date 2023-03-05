import 'package:flutter_test/flutter_test.dart';
import 'package:analytics_logger_gen/analytics_logger_gen.dart';
import 'package:analytics_logger_gen/analytics_logger_gen_platform_interface.dart';
import 'package:analytics_logger_gen/analytics_logger_gen_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAnalyticsLoggerGenPlatform
    with MockPlatformInterfaceMixin
    implements AnalyticsLoggerGenPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AnalyticsLoggerGenPlatform initialPlatform = AnalyticsLoggerGenPlatform.instance;

  test('$MethodChannelAnalyticsLoggerGen is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAnalyticsLoggerGen>());
  });

  test('getPlatformVersion', () async {
    AnalyticsLoggerGen analyticsLoggerGenPlugin = AnalyticsLoggerGen();
    MockAnalyticsLoggerGenPlatform fakePlatform = MockAnalyticsLoggerGenPlatform();
    AnalyticsLoggerGenPlatform.instance = fakePlatform;

    expect(await analyticsLoggerGenPlugin.getPlatformVersion(), '42');
  });
}
