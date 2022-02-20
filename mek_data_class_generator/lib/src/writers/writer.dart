import 'package:mek_data_class_generator/src/specs.dart';

abstract class Writer {
  final ClassSpec classSpec;
  final List<FieldSpec> fieldSpecs;

  const Writer({required this.classSpec, required this.fieldSpecs});

  Iterable<String> writeMethods() sync* {}

  Iterable<String> writeClasses() sync* {}

  String writeMethodBody(String Function() writer) {
    return classSpec.element.isAbstract ? ';' : writer();
  }

  String visibility(bool isVisible) => isVisible ? '' : '_';
}
