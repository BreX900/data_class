import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class_generator/src/class_elements.dart';
import 'package:mek_data_class_generator/src/configs/class_config.dart';
import 'package:mek_data_class_generator/src/configs/field_config.dart';
import 'package:mek_data_class_generator/src/configs/parameter_config.dart';
import 'package:meta/meta.dart';

abstract class HelperCore extends ClassElements {
  HelperCore({required super.options, required super.element});

  late final List<FieldElement> fields = allFields.where(_checkFieldConcrete).toList();
  late final List<FormalParameterElement> parameters = constructor.formalParameters;

  static final _fieldConfigs = Expando<Map<ClassConfig, FieldConfig>>();
  @protected
  FieldConfig fieldConfigOf(FieldElement element) =>
      (_fieldConfigs[element] ??= {}).putIfAbsent(config, () => FieldConfig.fromElement(element));

  static final _parametersConfigs = Expando<Map<ClassConfig, ParameterConfig>>();
  @protected
  ParameterConfig parameterConfigOf(FormalParameterElement element) =>
      (_parametersConfigs[element] ??= {}).putIfAbsent(
        config,
        () => ParameterConfig.fromElement(this, element),
      );

  @protected
  void registerMixinMethod(Method method);

  @protected
  void registerClass(Class class$);

  @protected
  void registerMixinSelfGetter();

  @mustCallSuper
  void register() {}

  @protected
  void writeNewInstance(
    StringBuffer buffer,
    void Function(FormalParameterElement parameter) writer,
  ) {
    if (constructor.formalParameters.isEmpty) {
      if (constructor.isConst) buffer.write('const ');
      buffer.write(constructor.displayName);
      buffer.write('()');
    } else {
      buffer.write(constructor.displayName);
      buffer.write('(');
      for (final parameter in parameters) {
        buffer.write('  ');
        if (!parameter.isPositional) {
          buffer.write(parameter.displayName);
          buffer.write(': ');
        }
        writer(parameter);
        buffer.write(',\n');
      }
      buffer.write(')');
    }
  }

  static bool _checkFieldConcrete(FieldElement field) => !field.isAbstract && !field.isLate;
}
