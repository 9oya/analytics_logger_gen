# analytics_logger_gen

[analytics_logger_gen](https://github.com/9oya/analytics_logger_gen) is a Flutter plugin that generates an integrated event logger for various analytics tools including Firebase, AppsFlyer, Amplitude, Mixpanel, Singular, and DataDog. Import data from Google Spreadsheets, remote repositories, or local CSV files.

## Running the generator
```shell
flutter packages pub run build_runner build

# if you want to delete the generated files before building
flutter packages pub run build_runner build --delete-conflicting-outputs

# if generated files are not updated after modifying the CSV file
flutter pub run build_runner clean
```
## Basic Usage
The builders generate code when they find members annotated with `@AnalyticsLogger`.
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// Building creates the corresponding part 'analytics_logger.g.dart'
part 'analytics_logger.g.dart';

@AnalyticsLogger(
    // ex) (from project root)assets/logger_gen_example_sheet.csv
    localCsvPath: '<PATH-TO-CSV-FILE>',
    // When you declare the localCsvPath, the remoteCsvUrl is ignored.
    remoteCsvUrl: '<URL-TO-CSV-FILE>',
    
    loggers: {
      // COLUMN_NAME is the name of the column in the CSV file
      // The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [1] to enable the logger, 
      // and [FALSE], [0] or [NULL] to disable the logger.
      FirebaseAnalyticsLogger: '<COLUMN-NAME>',
    })
// The class should be declared private '_' to avoid conflicts with the generated class
// ignore: unused_element
class _CommonAnalyticsLogger {}

// You can declare any number of loggers for third-party analytics tools.
class FirebaseAnalyticsLogger extends EventLogger {
  FirebaseAnalyticsLogger();

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
- You can add any number of columns to the right of the `arguments` column. 
- The values of the columns are used to determine whether to call the corresponding analytics tool. 
- The value of the [COLUMN_NAME] in the CSV file should be [TRUE] or [1] to enable the logger, and [FALSE], [0] or [NULL] to disable the logger.

| event_name              | arguments              | enableFirebase | hasAppsFlyer | customColumnName1 | customColumnName2 | customColumnName3 | customColumnName4 | description |
| -----------------------| ----------------------| -------------- | ------------ | -----------------| -----------------| -----------------| -----------------| ----------- |
| app_started             |                        | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| home_page_entered       | ab_test_case           | TRUE           | TRUE         | TRUE             | TRUE             | FALSE            | TRUE             |             |
| my_page_entered         | ab_test_case           | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| app_ended               |                        | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | FALSE            |             |
| home_bottom_button_clicked | a, b, c, d           | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |
| select_contents         | content_type, item_id  | TRUE           | FALSE        | FALSE            | FALSE            | FALSE            | FALSE            |             |
| my_send_message_clicked | title, message         | FALSE          | TRUE         | TRUE             | TRUE             | FALSE            | TRUE             |             |
| home_banner_button_clicked | is_allowed           | TRUE           | TRUE         | TRUE             | TRUE             | TRUE             | TRUE             |             |

[download example csv file](https://raw.githubusercontent.com/9oya/analytics_logger_gen_example_public_docs-/main/logger_gen_example_v2.csv)

### Prerequisites for running the code generation
#### Local CSV file
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_local_file.g.dart';

@AnalyticsLogger(
    localCsvPath: 'assets/logger_gen_example_v2.csv',
    loggers: {
      FirebaseAnalyticsLogger: 'enableFirebase',
      AppsFlyerLogger: 'hasAppsFlyer',
      AmplitudeLogger: 'customizableName1',
      MixpanelLogger: 'customizableName2',
      SingularLogger: 'customizableName3',
      DatadogDebugLogger: 'customizableName4',
    },
    providerName: 'AnalyticsEventProviderC',
    eventTypeName: 'AnalyticsEventC')
// ignore: unused_element
class _CommonAnalyticsLogger {}

```
#### Remote CSV file
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_google_spread_sheet.g.dart';

@AnalyticsLogger(
    remoteCsvUrl:
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vSziB4YXy4C777tDDHlW96iT-640jWsfpc0cJLCc114DWxNusSQs61EkrY5lhLcp0T1Wkj1IJWijQ-j/pub?gid=0&single=true&output=csv',
    loggers: {
      FirebaseAnalyticsLogger: 'enableFirebase',
      AppsFlyerLogger: 'hasAppsFlyer',
      AmplitudeLogger: 'customizableName1',
      MixpanelLogger: 'customizableName2',
      SingularLogger: 'customizableName3',
      DatadogDebugLogger: 'customizableName4',
    },
    providerName: 'AnalyticsEventProviderB',
    eventTypeName: 'AnalyticsEventB')
// ignore: unused_element
class _CommonAnalyticsLogger {}

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

part 'logger_from_google_spread_sheet.g.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum AnalyticsEvent {
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
      'home_banner_button_clicked', true, true, true, true, true, true),
  setUserId('set_user_id', true, false, false, false, false, false),
  setUserInfo('set_user_info', true, false, false, false, false, false),
  countIncreased('count_increased', true, true, false, false, false, false);

  const AnalyticsEvent(
      this.name,
      this.enableFirebase,
      this.hasAppsFlyer,
      this.customizableName1,
      this.customizableName2,
      this.customizableName3,
      this.customizableName4);
  final String name;
  final bool enableFirebase;
  final bool hasAppsFlyer;
  final bool customizableName1;
  final bool customizableName2;
  final bool customizableName3;
  final bool customizableName4;

  static AnalyticsEvent fromName(String name) {
    switch (name) {
      case 'app_started':
        return AnalyticsEvent.appStarted;
      case 'home_page_entered':
        return AnalyticsEvent.homePageEntered;
      case 'my_page_entered':
        return AnalyticsEvent.myPageEntered;
      case 'app_ended':
        return AnalyticsEvent.appEnded;
      case 'home_bottom_button_clicked':
        return AnalyticsEvent.homeBottomButtonClicked;
      case 'select_contents':
        return AnalyticsEvent.selectContents;
      case 'my_send_message_clicked':
        return AnalyticsEvent.mySendMessageClicked;
      case 'home_banner_button_clicked':
        return AnalyticsEvent.homeBannerButtonClicked;
      case 'set_user_id':
        return AnalyticsEvent.setUserId;
      case 'set_user_info':
        return AnalyticsEvent.setUserInfo;
      case 'count_increased':
        return AnalyticsEvent.countIncreased;
      default:
        throw ArgumentError('Invalid name: $name');
    }
  }
}

class AnalyticsEventProvider {
  AnalyticsEventProvider._();
  static void appStarted() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.appStarted, attributes);
  }

  static void homePageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.homePageEntered, attributes);
  }

  static void myPageEntered({dynamic abTestCase}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.myPageEntered, attributes);
  }

  static void appEnded() {
    Map<String, dynamic> attributes = <String, dynamic>{};
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.appEnded, attributes);
  }

  static void homeBottomButtonClicked(
      {dynamic a, dynamic b, dynamic c, dynamic d}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'a': a,
      'b': b,
      'c': c,
      'd': d,
    };
    CommonAnalyticsLogger.logEvent(
        AnalyticsEvent.homeBottomButtonClicked, attributes);
  }

  static void selectContents({dynamic contentType, dynamic itemId}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.selectContents, attributes);
  }

  static void mySendMessageClicked({dynamic title, dynamic message}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    CommonAnalyticsLogger.logEvent(
        AnalyticsEvent.mySendMessageClicked, attributes);
  }

  static void homeBannerButtonClicked({dynamic isAllowed}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'isAllowed': isAllowed,
    };
    CommonAnalyticsLogger.logEvent(
        AnalyticsEvent.homeBannerButtonClicked, attributes);
  }

  static void setUserId({dynamic id}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.setUserId, attributes);
  }

  static void setUserInfo({dynamic age, dynamic gender}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.setUserInfo, attributes);
  }

  static void countIncreased({dynamic count}) {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    CommonAnalyticsLogger.logEvent(AnalyticsEvent.countIncreased, attributes);
  }
}

class CommonAnalyticsLogger {
  CommonAnalyticsLogger._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
  FirebaseAnalyticsLogger();
  static AppsFlyerLogger appsFlyerLogger = AppsFlyerLogger();
  static AmplitudeLogger amplitudeLogger = AmplitudeLogger();
  static MixpanelLogger mixpanelLogger = MixpanelLogger();
  static SingularLogger singularLogger = SingularLogger();
  static DatadogDebugLogger datadogDebugLogger = DatadogDebugLogger();
  static void setup() {
    firebaseAnalyticsLogger.setup();
    appsFlyerLogger.setup();
    amplitudeLogger.setup();
    mixpanelLogger.setup();
    singularLogger.setup();
    datadogDebugLogger.setup();
  }

  static void logEvent(AnalyticsEvent event, Map<String, dynamic> attributes) {
    if (event.enableFirebase) {
      firebaseAnalyticsLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.hasAppsFlyer) {
      appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName1) {
      amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName2) {
      mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName3) {
      singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.customizableName4) {
      datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}


```