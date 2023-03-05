import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:analytics_logger_gen/analytics_logger_gen_method_channel.dart';

void main() {
  MethodChannelAnalyticsLoggerGen platform = MethodChannelAnalyticsLoggerGen();
  const MethodChannel channel = MethodChannel('analytics_logger_gen');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
