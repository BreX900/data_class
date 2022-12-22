import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class EqualityWriter extends Writer {
  const EqualityWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  Iterable<String> writeMethods() sync* {
    yield _generatePropsMethod();
    yield _generateEqualMethod();
    yield _generateHashcodeMethod();
  }

  String _generatePropsMethod() {
    return '''
  Iterable<Object?> get _props sync* {
${_writePropsFields().join('\n')}
  }''';
  }

  Iterable<String> _writePropsFields() sync* {
    for (var field in fieldSpecs) {
      if (!field.comparable) continue;

      yield '      yield _self.${field.name};';
    }
  }

  String _generateEqualMethod() {
    return '''
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ${classSpec.mixin.typedName} &&
          runtimeType == other.runtimeType &&
          DataClass.\$equals(_props, other._props);''';
  }

  String _generateHashcodeMethod() {
    return '''
    int get hashCode => Object.hashAll(_props);''';
  }
}
