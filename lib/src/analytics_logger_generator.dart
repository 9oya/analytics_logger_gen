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

    final String localCsvPath = annotation.read('localCsvPath').stringValue;
    final String remoteCsvPath = annotation.read('remoteCsvPath').stringValue;
    final bool firebaseAnalytics =
        annotation.read('firebaseAnalytics').boolValue;
    // TODO(eido9oy): Add support for other analytics providers
    // final bool appsflyer = annotation.read('appsflyer').boolValue;
    // final bool amplitude = annotation.read('amplitude').boolValue;
    // final bool mixpanel = annotation.read('mixpanel').boolValue;
    final bool singular = annotation.read('singular').boolValue;
    final bool dataDog = annotation.read('dataDog').boolValue;

    List<String> headerRows = <String>[];
    List<Map<String, dynamic>> bodyRows = <Map<String, dynamic>>[];

    try {
      final headers = {
        'Content-Type': 'text/csv; charset=utf-8',
        'Accept': '*/*'
      };
      Uri uri = localCsvPath.isNotEmpty
          ? Uri.parse(localCsvPath)
          : Uri.parse(remoteCsvPath);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<List<dynamic>> allRows =
            const CsvToListConverter().convert<String>(response.body);
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

    // enum AnalyticsEvents
    buffer.writeln('enum AnalyticsEvents {');
    for (int i = 0; i < bodyRows.length; i++) {
      String? snakeCaseName =
          bodyRows[i][headerRows[0]]!.toString().toSnakeCase();
      String? camelCaseName = snakeCaseName.toCamelCase();
      String hasFirebase = firebaseAnalytics ? 'true' : 'false';
      // TODO(eido9oy): Add support for other analytics providers
      // String hasAppsflyer = appsflyer ? 'true' : 'false';
      // String hasAmplitude = amplitude ? 'true' : 'false';
      // String hasMixpanel = mixpanel ? 'true' : 'false';
      String hasSingular = singular ? 'true' : 'false';
      String hasDataDog = dataDog ? 'true' : 'false';
      // TODO(eido9oy): Add support for other analytics providers
      // String outputLine =
      //     '$camelCaseName(\'$snakeCaseName\', $hasFirebase, $hasAppsflyer, $hasAmplitude, $hasMixpanel, $hasSingular, $hasDataDog)';
      String outputLine =
          '$camelCaseName(\'$snakeCaseName\', $hasFirebase, $hasSingular, $hasDataDog)';
      if (i < bodyRows.length - 1) {
        buffer.writeln('$outputLine,');
      } else {
        buffer.writeln('$outputLine;');
      }
    }
    // TODO(eido9oy): Add support for other analytics providers
    // buffer.writeln(
    //     'const AnalyticsEvents(this.name, this.hasFirebase, this.hasAppsflyer, this.hasAmplitude, this.hasMixpanel, this.hasSingular, this.hasDataDog);');
    buffer.writeln(
        'const AnalyticsEvents(this.name, this.hasFirebase, this.hasSingular, this.hasDataDog);');
    buffer.writeln('final String name;');
    buffer.writeln('final bool hasFirebase;');
    // TODO(eido9oy): Add support for other analytics providers
    // buffer.writeln('final bool hasAppsflyer;');
    // buffer.writeln('final bool hasAmplitude;');
    // buffer.writeln('final bool hasMixpanel;');
    buffer.writeln('final bool hasSingular;');
    buffer.writeln('final bool hasDataDog;');
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
      buffer.writeln(
          'CustomAnalyticsLogger.logEvent(AnalyticsEvents.$eventName, attributes);');
      buffer.writeln('}');
    }
    buffer.writeln('}');

    // abstract class EventLogger
    buffer.writeln('abstract class EventLogger {');
    buffer.writeln(
        'void logEvent(String event, {required Map<String, dynamic> attributes});');
    buffer.writeln('}');

    // FirebaseLogger
    buffer.writeln('class FirebaseLogger extends EventLogger {');
    buffer.writeln('FirebaseLogger({required this.firebase});');
    buffer.writeln('final FirebaseAnalytics firebase;');
    buffer.writeln('@override');
    buffer.writeln(
        'void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    buffer.writeln('firebase.logEvent(name: event, parameters: attributes);');
    buffer.writeln('}');
    buffer.writeln('}');

    // TODO(eido9oy): Add support for other analytics providers
    // AppsFlyerLogger
    // buffer.writeln('class AppsFlyerLogger extends EventLogger {');
    // buffer.writeln('}');

    // AmplitudeLogger
    // buffer.writeln('class AmplitudeLogger extends EventLogger {');
    // buffer.writeln('}');

    // MixpanelLogger
    // buffer.writeln('class MixpanelLogger extends EventLogger {');
    // buffer.writeln('}');

    // SingularLogger
    buffer.writeln('class SingularLogger extends EventLogger {');
    buffer.writeln('SingularLogger();');
    buffer.writeln('@override');
    buffer.writeln(
        'void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    buffer.writeln('Singular.eventWithArgs(event, attributes);');
    buffer.writeln('}');
    buffer.writeln('}');

    // DataDogLogger
    buffer.writeln('class DataDogLogger extends EventLogger {');
    buffer.writeln('DataDogLogger({required this.dataDog});');
    buffer.writeln('final DatadogSdk dataDog;');
    buffer.writeln('@override');
    buffer.writeln(
        'void logEvent(String event, {required Map<String, dynamic> attributes}) {');
    buffer.writeln('dataDog.logs?.info(event, attributes: attributes.cast<String, String>());');
    buffer.writeln('}');
    buffer.writeln('}');

    //class CustomAnalyticsLogger
    buffer.writeln('class $name {');
    buffer.writeln('$name._();');
    buffer.writeln(
        'static final EventLogger firebaseLogger = FirebaseLogger(firebase: FirebaseAnalytics.instance);');
    buffer
        .writeln('static final EventLogger singularLogger = SingularLogger();');
    buffer.writeln('static final EventLogger dataDogLogger = DataDogLogger(dataDog: DatadogSdk.instance);');

    buffer.writeln(
        'static void logEvent(AnalyticsEvents event, Map<String, dynamic> attributes) {');
    buffer.writeln('if (event.hasFirebase) {');
    buffer.writeln(
        'firebaseLogger.logEvent(event.name, attributes: attributes);');
    buffer.writeln('}');

    buffer.writeln('if (event.hasSingular) {');
    buffer.writeln(
        'singularLogger.logEvent(event.name, attributes: attributes);');
    buffer.writeln('}');

    buffer.writeln('if (event.hasDataDog) {');
    buffer.writeln(
        'dataDogLogger.logEvent(event.name, attributes: attributes);');
    buffer.writeln('}');

    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }
}
