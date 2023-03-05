import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import '../analytics_logger_gen.dart';

class AnalyticsLoggerGenerator extends GeneratorForAnnotation<AnalyticsLogger> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final buffer = StringBuffer();
    final name = element.displayName;
    buffer.writeln('extension \$${name} on ${name} {');

    buffer.writeln('}');
    return buffer.toString();
  }
}
