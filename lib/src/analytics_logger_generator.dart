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
    final bool appsflyer = annotation.read('appsflyer').boolValue;
    final bool amplitude = annotation.read('amplitude').boolValue;
    final bool mixpanel = annotation.read('mixpanel').boolValue;
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
      String hasAppsflyer = appsflyer ? 'true' : 'false';
      String hasAmplitude = amplitude ? 'true' : 'false';
      String hasMixpanel = mixpanel ? 'true' : 'false';
      String hasSingular = singular ? 'true' : 'false';
      String hasDataDog = dataDog ? 'true' : 'false';
      String outputLine =
          '$camelCaseName(\'$snakeCaseName\', $hasFirebase, $hasAppsflyer, $hasAmplitude, $hasMixpanel, $hasSingular, $hasDataDog)';
      if (i < bodyRows.length - 1) {
        buffer.writeln('$outputLine,');
      } else {
        buffer.writeln('$outputLine;');
      }
    }
    buffer.writeln(
        'const AnalyticsEvents(this.name, this.hasFirebase, this.hasAppsflyer, this.hasAmplitude, this.hasMixpanel, this.hasSingular, this.hasDataDog);');

    buffer.writeln('final String name;');
    buffer.writeln('final bool hasFirebase;');
    buffer.writeln('final bool hasAppsflyer;');
    buffer.writeln('final bool hasAmplitude;');
    buffer.writeln('final bool hasMixpanel;');
    buffer.writeln('final bool hasSingular;');
    buffer.writeln('final bool hasDataDog;');
    buffer.writeln('}');

    // class AnalyticsEventsProvider
    buffer.writeln('class AnalyticsEventsProvider {');
    buffer.writeln('}');

    // abstract class EventLogger
    buffer.writeln('abstract class EventLogger {');
    buffer.writeln('}');

    // FirebaseLogger
    buffer.writeln('class FirebaseLogger extends EventLogger {');
    buffer.writeln('}');

    // AppsFlyerLogger
    buffer.writeln('class AppsFlyerLogger extends EventLogger {');
    buffer.writeln('}');

    // AmplitudeLogger
    buffer.writeln('class AmplitudeLogger extends EventLogger {');
    buffer.writeln('}');

    // MixpanelLogger
    buffer.writeln('class MixpanelLogger extends EventLogger {');
    buffer.writeln('}');

    // SingularLogger
    buffer.writeln('class SingularLogger extends EventLogger {');
    buffer.writeln('}');

    // DataDogLogger
    buffer.writeln('class DataDogLogger extends EventLogger {');
    buffer.writeln('}');

    //class CustomAnalyticsLogger
    buffer.writeln('class ${name} {');
    buffer.writeln('}');

    return buffer.toString();
  }
}
