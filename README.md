# analytics_logger_gen

[analytics_logger_gen](https://github.com/9oya/analytics_logger_gen) is a Flutter plugin that generates an integrated event logger for analytics tools such as Firebase Analytics, AppsFlyer, Amplitude, MixpanelLogger, Singular and DataDog.

## Running the generator
```shell
flutter packages pub run build_runner build

# or if you want to delete the generated files before building
# flutter packages pub run build_runner build --delete-conflicting-outputs
```
## Basic Usage
The builders generate code when they find members annotated with `@AnalyticsLogger`.
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// Building creates the corresponding part 'analytics_logger_from_google_spread_sheet.g.dart'
part 'analytics_logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    localCsvPath: '<YOUR-PROJECT-ROOT/PATH-TO-CSV-FILE>',
    // When you declare the localCsvPath, the remoteCsvUrl is ignored.
    remoteCsvUrl: '<URL-TO-CSV-FILE>',
    
    loggers: {
      // COLUMN-NAME is the name of the column in the CSV file
      // The value of the COLUMN-NAME should be 'TRUE' or 'FALSE'
      '<COLUMN-NAME>': FirebaseAnalyticsLogger(),
    })
// The class should be declared private '_' to avoid conflicts with the generated class
// ignore: unused_element
class _CustomAnalyticsLogger {}

// You can declare any number of loggers for third-party analytics tools.
class FirebaseAnalyticsLogger extends EventLogger {
  const SomeAnalyticsLogger();

  @override
  void logEvent(String event, {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}
```
## Example
### Calling the generated code
```dart
AnalyticsEventsProvider.appStarted();
AnalyticsEventsProvider.mySendMessageClicked(
    title: 'hello', message: 'world');
AnalyticsEventsProvider.homeBottomButtonClicked(
    a: 'a', b: 'b', c: 'c', d: 'd');
```
### CSV file
- The indices of the `event_name` and `arguments` columns cannot be modified; they are fixed at column indices 0 and 1, respectively. (You can change their names, but not their indices.)
- You can add any number of columns to the right of the `arguments` column. The values of the columns are used to determine whether to call the corresponding analytics tool. The values of the columns should be 'TRUE' or 'FALSE'.

| event_name              | arguments                | enableFirebase | hasAppsFlyer | customColumnName1 | customColumnName2 | customColumnName3 | customColumnName4 | description |
| -----------------------| ------------------------| -------------- | ------------ | -----------------| -----------------| -----------------| -----------------| ----------- |
| app_started             |                          | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| home_page_entered       | ab_test_case             | TRUE           | TRUE         | TRUE             | TRUE             | FALSE            | TRUE             |             |
| my_page_entered         | ab_test_case             | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| app_ended               |                          | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | FALSE            |             |
| home_bottom_button_clicked | "a, b, c, d"           | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| select_contents         | content_type, item_id    | TRUE           | FALSE        | FALSE            | FALSE            | FALSE            | FALSE            |             |
| my_send_message_clicked | title, message           | FALSE          | TRUE         | TRUE             | TRUE             | FALSE            | TRUE             |             |
| home_banner_button_clicked | is_allowed            | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |

[download example csv file](https://raw.githubusercontent.com/9oya/analytics_logger_gen_example_public_docs-/main/logger_gen_example_sheet.csv)

### Prerequisites for running the code generation
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
### The generated code
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger_from_google_spread_sheet.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvents {
  appStarted('app_started', true, true, true, true, true, true),
  homePageEntered('home_page_entered', true, true, true, true, false, true),
  myPageEntered('my_page_entered', true, true, true, true, true, true),
  appEnded('app_ended', true, true, true, true, true, false),
  homeBottomButtonClicked(
      'home_bottom_button_clicked', true, true, true, true, true, true),
  selectContents('select_contents', true, false, false, false, false, false),
  mySendMessageClicked(
      'my_send_message_clicked', false, true, true, true, false, true),
  homeBannerButtonClicked(
      'home_banner_button_clicked', true, true, true, true, true, true);

  const AnalyticsEvents(
      this.name,
      this.enableFirebase,
      this.hasAppsFlyer,
      this.customColumnName1,
      this.customColumnName2,
      this.customColumnName3,
      this.customColumnName4);
  final String name;
  final bool enableFirebase;
  final bool hasAppsFlyer;
  final bool customColumnName1;
  final bool customColumnName2;
  final bool customColumnName3;
  final bool customColumnName4;
}

class AnalyticsEventsProvider {
  AnalyticsEventsProvider._();
  static void appStarted() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.appStarted, attributes);
  }

  static void homePageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homePageEntered, attributes);
  }

  static void myPageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.myPageEntered, attributes);
  }

  static void appEnded() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.appEnded, attributes);
  }

  static void homeBottomButtonClicked(
      {dynamic a, dynamic b, dynamic c, dynamic d}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
      'd': d,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homeBottomButtonClicked, attributes);
  }

  static void selectContents({dynamic contentType, dynamic itemId}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    CustomAnalyticsLoggerA.logEvent(AnalyticsEvents.selectContents, attributes);
  }

  static void mySendMessageClicked({dynamic title, dynamic message}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.mySendMessageClicked, attributes);
  }

  static void homeBannerButtonClicked({dynamic isAllowed}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'isAllowed': isAllowed,
    };
    CustomAnalyticsLoggerA.logEvent(
        AnalyticsEvents.homeBannerButtonClicked, attributes);
  }
}

class CustomAnalyticsLoggerA {
  CustomAnalyticsLoggerA._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
      const FirebaseAnalyticsLogger();
  static AppsFlyerLogger appsFlyerLogger = const AppsFlyerLogger();
  static AmplitudeLogger amplitudeLogger = const AmplitudeLogger();
  static MixpanelLogger mixpanelLogger = const MixpanelLogger();
  static SingularLogger singularLogger = const SingularLogger();
  static DatadogDebugLogger datadogDebugLogger = const DatadogDebugLogger();
  static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {
    if (event.enableFirebase) {
      firebaseAnalyticsLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasAppsFlyer) {
      appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName1) {
      amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName2) {
      mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName3) {
      singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customColumnName4) {
      datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}

```