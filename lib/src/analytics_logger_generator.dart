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
      // TODO(eido9oy): Add support for other analytics providers
      String outputLine = '$camelCaseName(\'$_eventSnakeCase\'';

      List<String> outputValues = [];
      // Find logger separator row index in headerRows and get value
      for(String loggerSeparatorKey in loggers.keys) {
        print('headerRows : $headerRows');
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

      print('outputLine : $outputLine');
    }
    // TODO(eido9oy): Add support for other analytics providers
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
    //
    // // abstract class EventLogger
    // buffer.writeln('abstract class EventLogger {');
    // buffer.writeln('void logEvent(String event, {required Map<String, dynamic> attributes});');
    // buffer.writeln('}');
    //
    // // FirebaseLogger
    // if (hasFirebaseAnalytics) {
    //   buffer.writeln('class FirebaseLogger extends EventLogger {');
    //   buffer.writeln('FirebaseLogger({required this.firebase});');
    //   buffer.writeln('final FirebaseAnalytics firebase;');
    //   buffer.writeln('@override');
    //   buffer.writeln('void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    //   buffer.writeln('firebase.logEvent(name: event, parameters: attributes);');
    //   buffer.writeln('}');
    //   buffer.writeln('}');
    // }
    //
    // // TODO(eido9oy): Add support for other analytics providers
    // // AppsFlyerLogger
    // // buffer.writeln('class AppsFlyerLogger extends EventLogger {');
    // // buffer.writeln('}');
    //
    // // AmplitudeLogger
    // // buffer.writeln('class AmplitudeLogger extends EventLogger {');
    // // buffer.writeln('}');
    //
    // // MixpanelLogger
    // // buffer.writeln('class MixpanelLogger extends EventLogger {');
    // // buffer.writeln('}');
    //
    // // SingularLogger
    // if (hasSingular) {
    //   buffer.writeln('class SingularLogger extends EventLogger {');
    //   buffer.writeln('SingularLogger();');
    //   buffer.writeln('@override');
    //   buffer.writeln('void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    //   buffer.writeln('Singular.eventWithArgs(event, attributes);');
    //   buffer.writeln('}');
    //   buffer.writeln('}');
    // }
    //
    // // DataDogLogger
    // if (hasDataDog) {
    //   buffer.writeln('class DataDogLogger extends EventLogger {');
    //   buffer.writeln('DataDogLogger({required this.dataDog});');
    //   buffer.writeln('final DatadogSdk dataDog;');
    //   buffer.writeln('@override');
    //   buffer.writeln('void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    //   buffer.writeln('dataDog.logs?.info(event, attributes: attributes.cast<String, String>());');
    //   buffer.writeln('}');
    //   buffer.writeln('}');
    // }

    //class CustomAnalyticsLogger
    buffer.writeln('class $name {');
    buffer.writeln('$name._();');
    // if (hasFirebaseAnalytics) {
    //       buffer.writeln(
    //       'static final EventLogger firebaseLogger = FirebaseLogger(firebase: FirebaseAnalytics.instance);');
    // }
    // if (hasSingular) {
    //   buffer.writeln('static final EventLogger singularLogger = SingularLogger();');
    // }
    // if (hasDataDog) {
    //   buffer.writeln(
    //       'static final EventLogger dataDogLogger = DataDogLogger(dataDog: DatadogSdk.instance);');
    // }

    for (String loggerName in loggers.values) {
      buffer.writeln(
          'static ${loggerName} ${loggerName.toLowerFirstCase()} = const ${loggerName}();');
    }

    buffer
        .writeln('static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {');
    // if (hasFirebaseAnalytics) {
    //   buffer.writeln('if (event.hasFirebase) {');
    //   buffer.writeln('firebaseLogger.logEvent(event.name, attributes: attributes);');
    //   buffer.writeln('}');
    // }
    // if (hasSingular) {
    //   buffer.writeln('if (event.hasSingular) {');
    //   buffer.writeln('singularLogger.logEvent(event.name, attributes: attributes);');
    //   buffer.writeln('}');
    // }
    // if (hasDataDog) {
    //   buffer.writeln('if (event.hasDataDog) {');
    //   buffer.writeln('dataDogLogger.logEvent(event.name, attributes: attributes);');
    //   buffer.writeln('}');
    // }

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
