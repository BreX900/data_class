import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';

class EqualityWriter extends Writer {
  EqualityWriter({required ClassSpec classSpec, required List<FieldSpec> fieldSpecs})
      : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  bool get available => classSpec.comparable;

  late final _fieldSpecs = fieldSpecs.where((e) => e.isParam && e.comparable);

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
    for (var field in _fieldSpecs) {
      if (field.equality != null) continue;

      yield '      yield _self.${field.name};';
    }
  }

  Iterable<String> _generateEquals() sync* {
    for (var field in _fieldSpecs) {
      if (field.equality == null) continue;

      yield '${field.equality}.equals(_self.${field.name}, other.${field.name})';
    }
  }

  String _generateEqualMethod() {
    var equals = _generateEquals().join(' && ');
    if (equals.isNotEmpty) equals = ' && $equals';

    return '''
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ${classSpec.self.typedName} &&
          runtimeType == other.runtimeType &&
          DataClass.\$equals(_props, other._props)$equals;''';
  }

  Iterable<String> _generateHashcodes() sync* {
    for (var field in _fieldSpecs) {
      if (field.equality == null) continue;

      yield '${field.equality}.hash(_self.${field.name})';
    }
  }

  String _generateHashcodeMethod() {
    var propsStr = '_props';
    final hascodes = _generateHashcodes().join(', ');
    if (hascodes.isNotEmpty) propsStr += '.followedBy([$hascodes])';

    return '''
    int get hashCode => Object.hashAll($propsStr);''';
  }
}
