import 'package:analytics_logger_gen_example/analytics_logger/analytics_logger.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    // AnalyticsEventsProvider.exampleEvent(param1: 'param1', param2: 'param2');

    // try {
    //   final headers = {
    //     'Content-Type': 'text/csv; charset=utf-8',
    //     'Accept': '*/*'
    //   };
    //   final response = await http.get(
    //       Uri.parse('https://docs.google.com/spreadsheets/d/e/2PACX-1vRdNT_NP48M631T55KV2rrMlEYAIe2pZ7m-ATWvlwdWVUkf1k2wvbh9b8tNSYR56Q93RwWUMSXI1-p3/pub?output=csv'),
    //       headers: headers);
    //
    //   if (response.statusCode == 200) {
    //     List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(response.body);
    //     List<String> attributes = rowsAsListOfValues[5][1].split(',');
    //     print(attributes);
    //   }
    //
    // } catch (e) {
    //   throw Exception(e);
    // }
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
