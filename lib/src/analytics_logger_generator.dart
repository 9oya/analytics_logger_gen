import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';

// ignore_for_file: implementation_imports
import 'package:build/src/builder/build_step.dart';
import 'package:change_case/change_case.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:source_gen/source_gen.dart';

import '../analytics_logger_gen.dart';

class AnalyticsLoggerGenerator extends GeneratorForAnnotation<AnalyticsLogger> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final buffer = StringBuffer();
    final className = element.displayName.replaceAll('_', '');
    final String localCsvPath = annotation.read('localCsvPath').stringValue;
    final String remoteCsvUrl = annotation.read('remoteCsvUrl').stringValue;

    List<List<dynamic>> allRows = <List<dynamic>>[];
    List<String> headerRows = <String>[];
    List<Map<String, dynamic>> bodyRows = <Map<String, dynamic>>[];

    if (localCsvPath.isNotEmpty) {
      // Get CSV from local path
      String fileContents = '';
      try {
        final Directory current = Directory.current;
        final File input = File('${current.path}/$localCsvPath');
        fileContents = input.readAsStringSync();
      } catch (e) {
        throw Exception(
            'Failed to get CSV from local path: $localCsvPath. Error: $e');
      }

      try {
        allRows = const CsvToListConverter().convert<dynamic>(fileContents);
      } catch (e) {
        throw Exception(
            'Failed to convert CSV from local path: $localCsvPath. Error: $e');
      }
    } else {
      // Get CSV from remote URL
      // Set default headers
      final Map<String, String> httpHeaders = {
        'Content-Type': 'text/csv; charset=utf-8',
        'Accept': '*/*'
      };
      // Add custom http headers
      annotation.read('httpHeaders').mapValue.forEach((k, v) {
        httpHeaders[k!.toStringValue()!] = v!.toStringValue()!;
      });
      try {
        Uri uri = Uri.parse(remoteCsvUrl);
        final response = await http.get(uri, headers: httpHeaders);
        if (response.statusCode == 200) {
          allRows = const CsvToListConverter().convert<dynamic>(response.body);
        } else {
          throw Exception(
              'Failed to get CSV from remote URL: $remoteCsvUrl. Status code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception(
            'Failed to get CSV from remote URL: $remoteCsvUrl. Error: $e');
      }
    }

    try {
      headerRows = allRows[0].map((dynamic e) => e.toString()).toList();
      bodyRows = allRows.sublist(1, allRows.length).map((List<dynamic> e) {
        Map<String, dynamic> dict = <String, dynamic>{};
        for (int i = 0; i < e.length; i++) {
          dict[headerRows[i]] = e[i];
        }
        return dict;
      }).toList();
    } catch (e) {
      throw Exception(
          'Failed to parse CSV. Please check the format of the CSV file. Error: $e');
    }

    // enum AnalyticsEvent
    final String _enumName = annotation.read('eventTypeName').stringValue;
    buffer.writeln('enum $_enumName {');
    final Map<String, String> eventLoggerNamesDict = annotation
        .read('loggers')
        .mapValue
        .map<String, String>((k, v) => MapEntry<String, String>(
              k!.toTypeValue().toString().replaceAll('*', ''),
              v!.toStringValue()!,
            ));
    for (int i = 0; i < bodyRows.length; i++) {
      String? _snakeCaseEventName =
          bodyRows[i][headerRows[0]]!.toString().toSnakeCase();
      String? _camelCaseEventName = _snakeCaseEventName.toCamelCase();
      String outputLine = '$_camelCaseEventName(\'$_snakeCaseEventName\'';

      // Validate event flag values in a row
      List<String> _outputValues = [];
      for (String _eventLoggerColumnName in eventLoggerNamesDict.values) {
        if (!headerRows.contains(_eventLoggerColumnName)) {
          throw Exception(
              'The event flag names for the \'$_eventLoggerColumnName\' in the header row ($headerRows) of the CSV file do not match those declared in the @AnalyticsLogger annotation.');
        }

        int _indexOfEventLoggerName = headerRows.indexOf(_eventLoggerColumnName);
        String _eventFlagKey = headerRows[_indexOfEventLoggerName];
        String _eventFlag = 'false';
        if (bodyRows[i][_eventFlagKey] != null) {
          try {
            String? eventFlagStr = bodyRows[i][_eventFlagKey].toString();
            if (eventFlagStr.isNotEmpty) {
              if (eventFlagStr == '0' || eventFlagStr == '1') {
                _eventFlag = eventFlagStr == '1' ? 'true' : 'false';
              } else {
                eventFlagStr = eventFlagStr.toUpperCase();
                if (eventFlagStr == 'TRUE' || eventFlagStr == 'FALSE') {
                  _eventFlag = eventFlagStr == 'TRUE' ? 'true' : 'false';
                }
              }
            }
          } catch (e) {
            throw Exception(
                'Failed to parse the event flag value for the \'$_eventLoggerColumnName\' in the row ${i + 1} of the CSV file.');
          }
        }
        _outputValues.add(_eventFlag);
      }

      // Add event flag values to the output line
      for (int j = 0; j < _outputValues.length; j++) {
        if (_outputValues[j] != '') {
          outputLine += ', ${_outputValues[j]}';
        }
      }

      outputLine += ')';
      if (i < bodyRows.length - 1) {
        buffer.writeln('$outputLine,');
      } else {
        buffer.writeln('$outputLine;');
      }
    }
    buffer.writeln('const $_enumName(this.name');
    for (String _eventLoggerColumnName in eventLoggerNamesDict.values) {
      buffer.writeln(', this.$_eventLoggerColumnName');
    }
    buffer.writeln(');');

    buffer.writeln('final String name;');
    for (String _eventLoggerColumnName in eventLoggerNamesDict.values) {
      buffer.writeln('final bool $_eventLoggerColumnName;');
    }

    buffer.writeln('');
    buffer.writeln('static $_enumName fromName(String name) {');
    buffer.writeln('switch (name) {');
    for (int i = 0; i < bodyRows.length; i++) {
      String? eventName = bodyRows[i][headerRows[0]]!.toString().toCamelCase();
      buffer.writeln('case \'${bodyRows[i][headerRows[0]]}\':');
      buffer.writeln('return $_enumName.$eventName;');
    }
    buffer.writeln('default:');
    buffer.writeln('throw ArgumentError(\'Invalid name: \$name\');');
    buffer.writeln('}'); // end of switch (name)
    buffer.writeln('}'); // end of static AnalyticsEvent fromName(String name)
    buffer.writeln('}'); // end of enum AnalyticsEvent

    // class AnalyticsEventProvider
    final String providerName = annotation.read('providerName').stringValue;
    buffer.writeln('class $providerName {');
    buffer.writeln('$providerName._();');
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
      buffer.writeln(
          '$className.logEvent($_enumName.$eventName, attributes);');
      buffer.writeln('}');
    }
    buffer.writeln('}');

    //class IntegratedAnalyticsLogger
    buffer.writeln('class $className {');
    buffer.writeln('$className._();');

    for (String _loggerName in eventLoggerNamesDict.keys) {
      buffer.writeln(
          'static $_loggerName ${_loggerName.toLowerFirstCase()} = $_loggerName();');
    }

    buffer.writeln('static void setup() {');
    for (String _loggerName in eventLoggerNamesDict.keys) {
      buffer.writeln(
          '${_loggerName.toLowerFirstCase()}.setup();');
    }
    buffer.writeln('}');

    buffer.writeln(
        'static void logEvent($_enumName event, Map<String, dynamic> attributes) {');

    for (String _loggerName in eventLoggerNamesDict.keys) {
      buffer.writeln('if (event.${eventLoggerNamesDict[_loggerName]}) {');
      buffer.writeln(
          '${_loggerName.toLowerFirstCase()}.logEvent(event.name, attributes: attributes);');
      buffer.writeln('}');
    }

    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }
}
