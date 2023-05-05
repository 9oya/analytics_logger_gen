# analytics_logger_gen

[analytics_logger_gen](https://github.com/9oya/analytics_logger_gen) is a code generator that generates analytics events for tools like FirebaseAnalytics. Import events from Google Spreadsheets, remote repositories or local CSV files.

## Running the generator
```shell
flutter packages pub run build_runner build
```
<details>
<summary>Other useful commands</summary>

```shell
flutter packages pub run build_runner build --delete-conflicting-outputs
# if you want to delete the generated files before building

flutter pub run build_runner clean
# if generated files are not updated after modifying the CSV file
```
</details>

## Calling the generated code
You can call the generated code from anywhere in your project with `Future` type methods.
```dart
await EventProvider.setup();

EventProvider.appStarted(title: 'Hello', message: 'world');
```

## Annotation based code generation
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
    
    loggers: <Type, String>{
      // The key of the map is the Type of the class that implements the [EventLogger] interface.
      //
      // Matching <CSV-COLUMN-NAME> in @AnalyticsLogger with CSV column determines which analytics tool to call for generated events.
      FirebaseAnalyticsLogger: '<CSV-COLUMN-NAME>',
    })
// The class should be declared private '_' to avoid conflicts with the generated class
// ignore: unused_element
class _EventLoggerContainer {}

// You can declare any number of loggers for third-party analytics tools.
class FirebaseAnalyticsLogger extends EventLogger {
  FirebaseAnalyticsLogger();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> setup() async {
    await Firebase.initializeApp();
    super.setup();
  }

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    switch (EventType.fromName(event)) {
      case EventType.setUserId:
        await _analytics.setUserId(
            id: attributes.values.first?.value.toString());
        break;
      case EventType.setUserInfo:
        for (final entry in attributes.entries) {
          await _analytics.setUserProperty(
            name: entry.key,
            value: entry.value,
          );
        }
        break;
      default:
        await _analytics.logEvent(name: event, parameters: attributes);
    }
  }}
  }
}
```
## Examples
### Calling the generated code
```dart
EventProvider.appStarted();

EventProvider.buttonClicked(abTestCase: 'A');

EventProvider.purchase(productId: 'product-id', price: 100, currency: 'USD', quantity: 1);
```
### CSV file
- The indices of the `event_name` and `arguments` columns cannot be modified; they are fixed at column indices 0 and 1, respectively. (You can change their names, but not their indices.)
- You can add any number of columns to the right of the `arguments` column.
- Matching columns in the 'loggers' Map property value of @AnalyticsLogger determine which analytics tool to call for generated events.
- Use [TRUE]/[1] to enable logger, [FALSE]/[0]/[ ] to disable.

| event_name            | arguments               | isFirebaseEnabled | isAppsFlyerEnabled | isAmplitudeEnabled | isMixpanelEnabled | isSingularEnabled | isDatadogEnabled | description                                  |
|-----------------------|-------------------------|-------------------|--------------------|---------------------|-------------------|--------------------|------------------|----------------------------------------------|
| app_started           | title, message          | TRUE              | TRUE               | TRUE                | TRUE              | TRUE               | TRUE             |                                              |
| home_page_entered     | ab_test_case            | TRUE              | TRUE               | TRUE                | TRUE              |                   | TRUE             |                                              |
| app_ended             |                         | TRUE              | TRUE               | TRUE                | TRUE              | TRUE               |                  |                                              |
| button_clicked        | ab_test_case            | TRUE              | TRUE               | TRUE                | TRUE              | TRUE               | TRUE             |                                              |
| select_contents       | content_type, item_id   | TRUE              |                    |                     |                   |                    |                  |                                              |
| send_message          | title, message          |                   | TRUE               | TRUE                | TRUE              |                   | TRUE             |                                              |
| banner_clicked        |                         | TRUE              | TRUE               | TRUE                | TRUE              | TRUE               | TRUE             |                                              |
| set_user_id           | id                      | TRUE              |                    |                     |                   |                    |                  |                                              |
| set_user_info         | age, gender             | TRUE              |                    |                     |                   |                    |                  |                                              |
| purchase              | productId, price, currency, quantity | TRUE              |                    |                     |                   |                    |                  |                                              |


[download example csv file](https://raw.githubusercontent.com/9oya/analytics_logger_gen_example_public_docs-/main/logger_gen_example_v3.csv)

### Prerequisites for running the code generation
#### Local CSV file
```dart
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

import '../event_logger_impls/event_loggers.dart';

part 'logger_from_local_file.g.dart';

@AnalyticsLogger(
    localCsvPath: 'assets/logger_gen_example_v3.csv',
    loggers: {
      FirebaseAnalyticsLogger: 'isFirebaseEnabled',
      AppsFlyerLogger: 'isAppsFlyerEnabled',
      AmplitudeLogger: 'isAmplitudeEnabled',
      MixpanelLogger: 'isMixpanelEnabled',
      SingularLogger: 'isSingularEnabled',
      DatadogDebugLogger: 'isDatadogEnabled',
    },
    providerName: 'EventProvider',
    eventTypeName: 'EventType')
// ignore: unused_element
class _EventLoggerContainer {}
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
      FirebaseAnalyticsLogger: 'isFirebaseEnabled',
      AppsFlyerLogger: 'isAppsFlyerEnabled',
      AmplitudeLogger: 'isAmplitudeEnabled',
      MixpanelLogger: 'isMixpanelEnabled',
      SingularLogger: 'isSingularEnabled',
      DatadogDebugLogger: 'isDatadogEnabled',
    },
    providerName: 'EventProvider',
    eventTypeName: 'EventType')
// ignore: unused_element
class _EventLoggerContainer {}

class FirebaseAnalyticsLogger extends EventLogger {
  FirebaseAnalyticsLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}

class AppsFlyerLogger extends EventLogger {
  AppsFlyerLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}

class AmplitudeLogger extends EventLogger {
  AmplitudeLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) {
    // Do something with the event and attributes
  }
}

class MixpanelLogger extends EventLogger {
  MixpanelLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}

class SingularLogger extends EventLogger {
  SingularLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}

class DatadogDebugLogger extends EventLogger {
  DatadogDebugLogger();

  @override
  Future<void> logEvent(String event,
      {required Map<String, dynamic> attributes}) async {
    // Do something with the event and attributes
  }
}


```
### The generated code
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// AnalyticsLoggerGenerator
// **************************************************************************

enum EventType {
  appStarted('app_started', true, true, true, true, true, true),
  homePageEntered('home_page_entered', true, true, true, true, false, true),
  appEnded('app_ended', true, true, true, true, true, false),
  buttonClicked('button_clicked', true, true, true, true, true, true),
  selectContents('select_contents', true, false, false, false, false, false),
  sendMessage('send_message', false, true, true, true, false, true),
  countIncreased('countIncreased', true, true, true, true, true, true),
  bannerClicked('banner_clicked', true, true, true, true, true, true),
  setUserId('set_user_id', true, false, false, false, false, false),
  setUserInfo('set_user_info', true, false, false, false, false, false),
  purchase('purchase', true, false, false, false, false, false);

  const EventType(
      this.name,
      this.isFirebaseEnabled,
      this.isAppsFlyerEnabled,
      this.isAmplitudeEnabled,
      this.isMixpanelEnabled,
      this.isSingularEnabled,
      this.isDatadogEnabled);
  final String name;
  final bool isFirebaseEnabled;
  final bool isAppsFlyerEnabled;
  final bool isAmplitudeEnabled;
  final bool isMixpanelEnabled;
  final bool isSingularEnabled;
  final bool isDatadogEnabled;

  static EventType fromName(String name) {
    switch (name) {
      case 'app_started':
        return EventType.appStarted;
      case 'home_page_entered':
        return EventType.homePageEntered;
      case 'app_ended':
        return EventType.appEnded;
      case 'button_clicked':
        return EventType.buttonClicked;
      case 'select_contents':
        return EventType.selectContents;
      case 'send_message':
        return EventType.sendMessage;
      case 'countIncreased':
        return EventType.countIncreased;
      case 'banner_clicked':
        return EventType.bannerClicked;
      case 'set_user_id':
        return EventType.setUserId;
      case 'set_user_info':
        return EventType.setUserInfo;
      case 'purchase':
        return EventType.purchase;
      default:
        throw ArgumentError('Invalid name: $name');
    }
  }
}

class EventProvider {
  EventProvider._();

  static Future<void> appStarted({dynamic title, dynamic message}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    await EventLoggerContainer.logEvent(EventType.appStarted, attributes);
  }

  static Future<void> homePageEntered({dynamic abTestCase}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    await EventLoggerContainer.logEvent(EventType.homePageEntered, attributes);
  }

  static Future<void> appEnded() async {
    Map<String, dynamic> attributes = <String, dynamic>{};
    await EventLoggerContainer.logEvent(EventType.appEnded, attributes);
  }

  static Future<void> buttonClicked({dynamic abTestCase}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'abTestCase': abTestCase,
    };
    await EventLoggerContainer.logEvent(EventType.buttonClicked, attributes);
  }

  static Future<void> selectContents(
      {dynamic contentType, dynamic itemId}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'contentType': contentType,
      'itemId': itemId,
    };
    await EventLoggerContainer.logEvent(EventType.selectContents, attributes);
  }

  static Future<void> sendMessage({dynamic title, dynamic message}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'title': title,
      'message': message,
    };
    await EventLoggerContainer.logEvent(EventType.sendMessage, attributes);
  }

  static Future<void> countIncreased({dynamic count}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'count': count,
    };
    await EventLoggerContainer.logEvent(EventType.countIncreased, attributes);
  }

  static Future<void> bannerClicked() async {
    Map<String, dynamic> attributes = <String, dynamic>{};
    await EventLoggerContainer.logEvent(EventType.bannerClicked, attributes);
  }

  static Future<void> setUserId({dynamic id}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'id': id,
    };
    await EventLoggerContainer.logEvent(EventType.setUserId, attributes);
  }

  static Future<void> setUserInfo({dynamic age, dynamic gender}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'age': age,
      'gender': gender,
    };
    await EventLoggerContainer.logEvent(EventType.setUserInfo, attributes);
  }

  static Future<void> purchase(
      {dynamic productId,
        dynamic price,
        dynamic currency,
        dynamic quantity}) async {
    Map<String, dynamic> attributes = <String, dynamic>{
      'productId': productId,
      'price': price,
      'currency': currency,
      'quantity': quantity,
    };
    await EventLoggerContainer.logEvent(EventType.purchase, attributes);
  }
}

class EventLoggerContainer {
  EventLoggerContainer._();
  static FirebaseAnalyticsLogger firebaseAnalyticsLogger =
  FirebaseAnalyticsLogger();
  static AppsFlyerLogger appsFlyerLogger = AppsFlyerLogger();
  static AmplitudeLogger amplitudeLogger = AmplitudeLogger();
  static MixpanelLogger mixpanelLogger = MixpanelLogger();
  static SingularLogger singularLogger = SingularLogger();
  static DatadogDebugLogger datadogDebugLogger = DatadogDebugLogger();

  static Future<void> setup() async {
    await firebaseAnalyticsLogger.setup();
    await appsFlyerLogger.setup();
    await amplitudeLogger.setup();
    await mixpanelLogger.setup();
    await singularLogger.setup();
    await datadogDebugLogger.setup();
  }

  static Future<void> logEvent(
      EventType event, Map<String, dynamic> attributes) async {
    if (event.isFirebaseEnabled) {
      await firebaseAnalyticsLogger.logEvent(event.name,
          attributes: attributes);
    }
    if (event.isAppsFlyerEnabled) {
      await appsFlyerLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isAmplitudeEnabled) {
      await amplitudeLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isMixpanelEnabled) {
      await mixpanelLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isSingularEnabled) {
      await singularLogger.logEvent(event.name, attributes: attributes);
    }
    if (event.isDatadogEnabled) {
      await datadogDebugLogger.logEvent(event.name, attributes: attributes);
    }
  }
}
```