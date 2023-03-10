import 'package:analytics_logger_gen_example/analytics_logger/from_git_hub_private_repo/analytics_logger_from_private_repo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AnalyticsEventsProvider.appStarted();
    AnalyticsEventsProvider.mySendMessageClicked(
        title: 'hello', message: 'world');
    AnalyticsEventsProvider.homeBottomButtonClicked(
        a: 'a', b: 'b', c: 'c', d: 'd');
  }

  @override
  void dispose() {
    AnalyticsEventsProvider.appEnded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text('Running on:'),
        ),
      ),
    );
  }
}
