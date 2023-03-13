# analytics_logger_gen

[analytics_logger_gen](https://github.com/9oya/analytics_logger_gen) is a Flutter plugin that generates an integrated event logger for analytics tools such as Firebase Analytics, AppsFlyer, Amplitude, MixpanelLogger, Singular and DataDog.

## Installation
```xml
dependencies:
  analytics_logger_gen:
```
## Example
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

part 'analytics_logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
        'https://docs.google.com/spreadsheets/d/e/2PACX-1vSwehSB_tVWzgaeVowghmaRODQdeGvriangiPy7C1ZzDcxq_j1GD7WhTH4HAlMeGTE3fs-ZZ84R45Jw/pub?gid=0&single=true&output=csv',
    loggers: {
      'enableFirebase': FirebaseAnalyticsLogger(),
      'hasAppsFlyer': AppsFlyerLogger(),
      'customColumnName1': AmplitudeLogger(),
      'customColumnName2': MixpanelLogger(),
      'customColumnName3': SingularLogger(),
      'customColumnName4': DatadogDebugLogger(),
    })
// ignore: unused_element
class _CustomAnalyticsLoggerA {}

class FirebaseAnalyticsLogger extends EventLogger {
  const FirebaseAnalyticsLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class AppsFlyerLogger extends EventLogger {
  const AppsFlyerLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class AmplitudeLogger extends EventLogger {
  const AmplitudeLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class MixpanelLogger extends EventLogger {
  const MixpanelLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class SingularLogger extends EventLogger {
  const SingularLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class DatadogDebugLogger extends EventLogger {
  const DatadogDebugLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}


```

## Running the code generator
```shell
flutter packages pub run build_runner build
```