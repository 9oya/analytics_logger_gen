import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:csv/csv.dart';
import 'package:source_gen/source_gen.dart';
import 'package:http/http.dart' as http;
import 'package:change_case/change_case.dart';

import '../analytics_logger_gen.dart';

class AnalyticsLoggerGenerator extends GeneratorForAnnotation<AnalyticsLogger> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final buffer = StringBuffer();
    final name = element.displayName.replaceAll('_', '');

    final String remoteCsvUrl = annotation.read('remoteCsvUrl').stringValue;
    final Map<String, String> loggers = annotation.read('loggers').mapValue.map<String, String>(
        (k, v) => MapEntry<String, String>(
            k!.toStringValue()!, v!.type!.getDisplayString(withNullability: false)));

    List<String> headerRows = <String>[];
    List<Map<String, dynamic>> bodyRows = <Map<String, dynamic>>[];

    // Get CSV from remote URL
    try {
      final headers = {'Content-Type': 'text/csv; charset=utf-8', 'Accept': '*/*'};
      Uri uri = Uri.parse(remoteCsvUrl);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<List<dynamic>> allRows = const CsvToListConverter().convert<String>(response.body);
        headerRows = allRows[0] as List<String>;
        bodyRows = allRows.sublist(1, allRows.length).map((List<dynamic> e) {
          Map<String, dynamic> dict = <String, dynamic>{};
          for (int i = 0; i < e.length; i++) {
            dict[headerRows[i]] = e[i];
          }
          return dict;
        }).toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    // Check if headerRows contains logger separator row
    for(String loggerSeparatorKey in loggers.keys) {
      if (!headerRows.contains(loggerSeparatorKey)) {
        throw Exception('Header row does not contain logger separator row: $loggerSeparatorKey');
      }
    }

    // enum AnalyticsEvents
    buffer.writeln('enum AnalyticsEvents {');
    for (int i = 0; i < bodyRows.length; i++) {
      String? _eventSnakeCase = bodyRows[i][headerRows[0]]!.toString().toSnakeCase();
      String? camelCaseName = _eventSnakeCase.toCamelCase();
      String outputLine = '$camelCaseName(\'$_eventSnakeCase\'';

      List<String> outputValues = [];
      // Find logger separator row index in headerRows and get value
      for(String loggerSeparatorKey in loggers.keys) {
        int row = headerRows.indexOf(loggerSeparatorKey);
        String? _enable = bodyRows[i][headerRows[row]] == 'TRUE' ? 'true' : 'false';
        outputValues.add(_enable);
      }

      // Add logger separator row value to outputLine
      for (int j = 0; j < outputValues.length; j++) {
        if (outputValues[j] != '') {
          outputLine += ', ${outputValues[j]}';
        }
      }

      outputLine += ')';
      if (i < bodyRows.length - 1) {
        buffer.writeln('$outputLine,');
      } else {
        buffer.writeln('$outputLine;');
      }

    }
    buffer.writeln('const AnalyticsEvents(this.name');
    for(String loggerSeparatorKey in loggers.keys) {
      buffer.writeln(', this.${loggerSeparatorKey}');
    }
    buffer.writeln(');');

    buffer.writeln('final String name;');
    for(String loggerSeparatorKey in loggers.keys) {
      buffer.writeln('final bool ${loggerSeparatorKey};');
    }
    buffer.writeln('}');

    // class AnalyticsEventsProvider
    buffer.writeln('class AnalyticsEventsProvider {');
    buffer.writeln('AnalyticsEventsProvider._();');
    for (int i = 0; i < bodyRows.length; i++) {
      String? eventName = bodyRows[i][headerRows[0]]!.toString().toCamelCase();
      String params = '';
      String paramsDict = '';

      List<String> args = bodyRows[i][headerRows[1]]!.toString().split(',');
      for (int j = 0; j < args.length; j++) {
        String? paramName = args[j].toCamelCase();
        if (paramName.isEmpty) {
          if (j > 0) {
            params += '}';
          }
          break;
        }
        if (j == 0) {
          params += '{';
        }
        if (paramName.isEmpty) {
          break;
        }
        params += 'dynamic $paramName';
        if (j < args.length - 1) {
          params += ', ';
        } else {
          params += '}';
        }

        paramsDict += '\'$paramName\': $paramName,';
      }
      buffer.writeln('static void $eventName($params) {');
      buffer.writeln('Map<String, dynamic> attributes = <String, dynamic>{');
      buffer.writeln(paramsDict);
      buffer.writeln('};');
      buffer.writeln('CustomAnalyticsLogger.logEvent(AnalyticsEvents.$eventName, attributes);');
      buffer.writeln('}');
    }
    buffer.writeln('}');

    //class CustomAnalyticsLogger
    buffer.writeln('class $name {');
    buffer.writeln('$name._();');

    for (String loggerName in loggers.values) {
      buffer.writeln(
          'static ${loggerName} ${loggerName.toLowerFirstCase()} = const ${loggerName}();');
    }

    buffer
        .writeln('static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {');

    for (String loggerKey in loggers.keys) {
      String loggerName = loggers[loggerKey]!;
      buffer.writeln('if (event.$loggerKey) {');
      buffer.writeln(
          '${loggerName.toLowerFirstCase()}.logEvent(event.name, attributes: attributes);');
      buffer.writeln('}');
    }

    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }
}
