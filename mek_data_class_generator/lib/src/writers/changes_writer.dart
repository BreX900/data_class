import 'package:analyzer/dart/element/element.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/specs.dart';
import 'package:mek_data_class_generator/src/utils.dart';
import 'package:mek_data_class_generator/src/writers/writer.dart';
import 'package:source_gen/source_gen.dart';

class ChangesWriter extends Writer {
  final Config config;

  ChangesWriter({
    required this.config,
    required ClassSpec classSpec,
    required List<FieldSpec> fieldSpecs,
  }) : super(classSpec: classSpec, fieldSpecs: fieldSpecs);

  late final List<FieldSpec> _paramsSpecs = fieldSpecs.where((e) => e.isParam).toList();

  @override
  bool get available => classSpec.changeable && _paramsSpecs.isNotEmpty;

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
    final hasNeedDataClass = _paramsSpecs.any((e) => !e.updatable);

    final dataClassVarName = hasNeedDataClass ? '_dc' : 'dc';
    final constructorParam = hasNeedDataClass
        ? 'this.$dataClassVarName'
        : '${classSpec.self.typedName} $dataClassVarName';

    String writeBuildBody() {
      return '''
       => ${classSpec.self.name}(
        ${_generateBuildMethodMapping(dataClassVarName).join()}
      );''';
    }

    return '''
  ${isAbstract ? 'abstract ' : ''}class ${classSpec.changes.fullTypedName} $superSelf{
    ${hasNeedDataClass ? 'final ${classSpec.self.typedName} _dc;' : ''}
    ${_generateClassFields(isAbstract: isAbstract).join('\n')}
    
    ${classSpec.changes.name}._($constructorParam) : ${_generateConstructorAssignments(dataClassVarName).join(', ')};
    
    ${_writeChangeClassMethod()}
      
    ${classSpec.self.typedName} build()${writeMethodBody(writeBuildBody)}
  }''';
  }

  Iterable<String> _generateClassFields({required bool isAbstract}) sync* {
    for (var field in _paramsSpecs) {
      if (!field.updatable) continue;

      yield '${field.getType(nullable: true)} ${field.name};';
    }
  }

  Iterable<String> _generateConstructorAssignments(String dataClassVarName) sync* {
    for (var field in _paramsSpecs) {
      if (!field.updatable) continue;

      yield '${field.name} = $dataClassVarName.${field.name}';
    }
  }

  String _writeChangeClassMethod() {
    String writeBody() {
      return ''' => updates(this);''';
    }

    return '''
  void update(void Function(${classSpec.changes.typedName} c) updates)${writeMethodBody(writeBody)}''';
  }

  Iterable<String> _generateBuildMethodMapping(String dataClassVarName) sync* {
    for (var field in _paramsSpecs) {
      yield '${field.name}: ${field.updatable ? '' : '$dataClassVarName.'}${field.name},\n';
    }
  }
}
