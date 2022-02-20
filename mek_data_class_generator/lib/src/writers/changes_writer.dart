import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';
import 'package:source_gen/source_gen.dart';

class ChangesWriter extends Writer {
  final Config config;

  const ChangesWriter({
    required this.config,
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  @override
  Iterable<String> writeMethods() sync* {
    yield _writeChangeMethod();
    yield _writeToChangesMethod();
  }

  String _writeChangeMethod() {
    String _writeBody() {
      return ''' {
    final changes = ${classSpec.changes.name}._(_self);
    updates(changes);
    return changes.build();
  }''';
    }

    return '''
  ${classSpec.self.typedName} change(void Function(${classSpec.changes.typedName} c) updates)${writeMethodBody(_writeBody)}''';
  }

  String _writeToChangesMethod() {
    String _writeBody() {
      return ''' => ${classSpec.changes.name}._(_self);''';
    }

    return '''
  ${classSpec.changes.typedName} toChanges()${writeMethodBody(_writeBody)}''';
  }

  @override
  Iterable<String> writeClasses() sync* {
    yield _writeChangesClass();
  }

  String _writeChangesClass() {
    final superType = findSuperDataClass(classSpec.element);
    var superSelf = '';
    if (superType != null) {
      final superSpec = ClassSpec.from(config, superType.element,
          ConstantReader(dataClassChecker.firstAnnotationOf(superType.element)));

      final superTypes = ClassSpec.t(superType.typeArguments.join(', '));
      final superName = '${visibility(superSpec.changesVisible)}${superType.element.name}Changes';
      superSelf = 'implements $superName$superTypes ';
    }

    final isAbstract = classSpec.element.isAbstract;

    String writeConstructor() {
      return '''\n
    ${classSpec.changes.name}._(${classSpec.self.typedName} self) 
      : ${_generateClassConstructorProperties().join(', ')};''';
    }

    String writeBuildBody() {
      return '''
       => ${classSpec.self.name}(
        ${_generateBuildMethodMapping().join()}
      );''';
    }

    return '''
  ${isAbstract ? 'abstract ' : ''}class ${classSpec.changes.fullTypedName} $superSelf{
    ${_generateClassFields(isAbstract: isAbstract).join('\n')}
    ${isAbstract ? '' : writeConstructor()}
      
    ${classSpec.self.typedName} build()${writeMethodBody(writeBuildBody)}
  }''';
  }

  Iterable<String> _generateClassFields({required bool isAbstract}) sync* {
    for (var field in fieldSpecs) {
      if (!field.updatable) continue;

      yield '${field.originalType} ${isAbstract ? 'get ' : ''}${field.name};';
    }
  }

  Iterable<String> _generateClassConstructorProperties() sync* {
    for (var field in fieldSpecs) {
      if (!field.updatable) continue;

      yield '${field.name} = self.${field.name}';
    }
  }

  Iterable<String> _generateBuildMethodMapping() sync* {
    for (var field in fieldSpecs) {
      if (!field.updatable) continue;

      yield '${field.name}: ${field.name},\n';
    }
  }
}
