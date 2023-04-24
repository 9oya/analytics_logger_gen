// ignore: depend_on_referenced_packages
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

class AppsFlyerLogger extends EventLogger {
  AppsFlyerLogger();

  final AppsflyerSdk _appsflyerSdk = AppsflyerSdk(AppsFlyerOptions(
      afDevKey: "DEV_KEY",
      appId: "APP_ID",
      showDebug: true,
      timeToWaitForATTUserAuthorization: 15));

  @override
  void logEvent(String event,
      {required Map<String, dynamic> attributes, Function? onComplete}) {
    _appsflyerSdk.logEvent(event, attributes);
  }
}
