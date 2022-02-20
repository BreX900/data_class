import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class EqualityWriter extends Writer {
  const EqualityWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  Iterable<String> writeMethods() sync* {
    yield _generatePropsMethod();
    yield _generateEqualMethod();
  }

  String _generatePropsMethod() {
    return '''
  List<Object?> get _props => [
      ${_writePropsFields().join('\n')}
      ];''';
  }

  Iterable<String> _writePropsFields() sync* {
    for (var field in fieldSpecs) {
      if (!field.stringify) continue;

      yield '_self.${field.name},';
    }
  }

  String _generateEqualMethod() {
    return '''
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ${classSpec.mixin.typedName} &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);''';
  }
}
