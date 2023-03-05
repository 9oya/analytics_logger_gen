import Flutter
import UIKit

public class SwiftAnalyticsLoggerGenPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "analytics_logger_gen", binaryMessenger: registrar.messenger())
    let instance = SwiftAnalyticsLoggerGenPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
