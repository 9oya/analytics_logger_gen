// ignore: depend_on_referenced_packages
import 'package:analytics_logger_gen/analytics_logger_gen.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

import '../event_logger_impls/event_loggers.dart';

part 'main.g.dart';

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
class _CommonAnalyticsLogger {}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    EventProvider.countIncreased(count: _counter);
  }

  @override
  void initState() {
    super.initState();
    CommonAnalyticsLogger.setup();
    EventProvider.appStarted();
  }

  @override
  void dispose() {
    EventProvider.appEnded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
