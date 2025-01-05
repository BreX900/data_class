import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/creators/creator.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';

class ToStringCreator extends Creator {
  ToStringCreator({
    required super.classSpec,
    required super.fieldSpecs,
  });

  @override
  bool get available => classSpec.stringify;

  @override
  bool get needMixinMethodSelf => _effectiveFieldSpecs.isNotEmpty;

  late final Iterable<FieldSpec> _effectiveFieldSpecs = (() {
    var fieldSpecs = this.fieldSpecs.where((field) => field.stringify);
    switch (classSpec.stringifyType) {
      case StringifyType.params:
        fieldSpecs = fieldSpecs.where((field) => field.isParam).toList();
      case StringifyType.fields:
    }
    return fieldSpecs;
  })();

  @override
  Iterable<Method> creteMixinMethods() sync* {
    yield _createMixinMethodToString();
  }

  Method _createMixinMethodToString() {
    final types = classSpec.types.isEmpty ? '' : ', ${classSpec.types}';

    final fields = _effectiveFieldSpecs.map((field) {
      final addType = classSpec.stringifyIfNull ? 'add' : 'addIfExist';
      final variable = '_self.${field.name}';
      final stringifier = field.stringifier;
      final stringifyVariable = stringifier != null ? '$stringifier($variable)' : variable;
      return '..$addType(${literalRawString(field.name)}, $stringifyVariable)';
    });

    final classToString =
        'ClassToString(${literalRawString(classSpec.self.name)}$types)${fields.join()}';

    return Method((b) => b
      ..annotations.add(Annotations.override)
      ..returns = Refs.string
      ..name = 'toString'
      ..lambda = true
      ..body =
          Code("${_effectiveFieldSpecs.isEmpty ? classToString : '($classToString)'}.toString()"));
  }
}
