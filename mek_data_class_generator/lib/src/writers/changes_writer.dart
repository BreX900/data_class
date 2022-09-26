import 'package:analyzer/dart/element/element.dart';
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
    String writeBody() {
      return ''' => (${classSpec.changes.typedName}._(_self)..update(updates)).build();''';
    }

    return '''
  ${classSpec.self.typedName} change(void Function(${classSpec.changes.typedName} c) updates)${writeMethodBody(writeBody)}''';
  }

  String _writeToChangesMethod() {
    String writeBody() {
      return ''' => ${classSpec.changes.name}._(_self);''';
    }

    return '''
  ${classSpec.changes.typedName} toChanges()${writeMethodBody(writeBody)}''';
  }

  @override
  Iterable<String> writeClasses() sync* {
    yield _writeChangesClass();
  }

  String _writeChangesClass() {
    final superType = findSuperDataClass(classSpec.element);
    var superSelf = '';
    if (superType != null) {
      final superSpec = ClassSpec.from(config, superType.element2 as ClassElement,
          ConstantReader(dataClassChecker.firstAnnotationOf(superType.element2)));

      final superTypes = ClassSpec.t(superType.typeArguments.join(', '));
      final superName = '${visibility(superSpec.changesVisible)}${superType.element2.name}Changes';
      superSelf = 'implements $superName$superTypes ';
    }

    final isAbstract = classSpec.element.isAbstract;

    String writeBuildBody() {
      return '''
       => ${classSpec.self.name}(
        ${_generateBuildMethodMapping().join()}
      );''';
    }

    return '''
  ${isAbstract ? 'abstract ' : ''}class ${classSpec.changes.fullTypedName} $superSelf{
    ${_generateClassFields(isAbstract: isAbstract).join('\n')}
    
    ${classSpec.changes.name}._(${classSpec.self.typedName} dataClass) {
      replace(dataClass);
    }
    
    ${_writeChangeClassMethod()}
    
    ${_writeReplaceClassMethod()}
      
    ${classSpec.self.typedName} build()${writeMethodBody(writeBuildBody)}
  }''';
  }

  Iterable<String> _generateClassFields({required bool isAbstract}) sync* {
    for (var field in fieldSpecs) {
      if (!field.updatable) continue;

      yield 'late ${field.originalType} ${field.name};';
    }
  }

  String _writeChangeClassMethod() {
    String writeBody() {
      return ''' => updates(this);''';
    }

    return '''
  void update(void Function(${classSpec.changes.typedName} c) updates)${writeMethodBody(writeBody)}''';
  }

  String _writeReplaceClassMethod() {
    Iterable<String> generateProperties() sync* {
      for (var field in fieldSpecs) {
        if (!field.updatable) continue;

        yield '${field.name} = dataClass.${field.name};';
      }
    }

    String writeBody() {
      return ''' {
      ${generateProperties().join('\n')}
    }''';
    }

    return '''
    void replace(covariant ${classSpec.self.typedName} dataClass)${writeMethodBody(writeBody)}
    ''';
  }

  Iterable<String> _generateBuildMethodMapping() sync* {
    for (var field in fieldSpecs) {
      if (!field.updatable) continue;

      yield '${field.name}: ${field.name},\n';
    }
  }
}
