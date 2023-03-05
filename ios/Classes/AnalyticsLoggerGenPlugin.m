#import "AnalyticsLoggerGenPlugin.h"
#if __has_include(<analytics_logger_gen/analytics_logger_gen-Swift.h>)
#import <analytics_logger_gen/analytics_logger_gen-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "analytics_logger_gen-Swift.h"
#endif

@implementation AnalyticsLoggerGenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnalyticsLoggerGenPlugin registerWithRegistrar:registrar];
}
@end
