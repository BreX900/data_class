import 'package:analyzer/dart/element/element.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/class_elements.dart';
import 'package:source_gen/source_gen.dart';

class ParameterConfig {
  static const _typeChecker = TypeChecker.typeNamed(DataParameter, inPackage: 'mek_data_class');

  final String accessor;
  final bool updatable;

  const ParameterConfig({required this.accessor, required this.updatable});

  factory ParameterConfig.fromElement(ClassElements elements, FormalParameterElement element) {
    final annotation = ConstantReader(_typeChecker.firstAnnotationOf(element));
    if (annotation.isNull) {
      return ParameterConfig(accessor: _findAccessor(elements, element), updatable: true);
    }
    return ParameterConfig(
      accessor: _findAccessor(elements, element),
      updatable: annotation.read('updatable').boolValue,
    );
  }

  static String _findAccessor(ClassElements elements, FormalParameterElement element) {
    final publicName = element.displayName;
    if (elements.allFields.any((field) => field.displayName == publicName)) return publicName;
    if (elements.allGetters.any((getter) => getter.displayName == publicName)) return publicName;

    final privateName = '_${element.displayName}';
    if (elements.allFields.any((field) => field.displayName == privateName)) return privateName;
    if (elements.allGetters.any((getter) => getter.displayName == privateName)) return privateName;

    throw InvalidGenerationSource(
      'Expose a "$publicName" or "$privateName" getter for '
      '"${elements.constructor.displayName}.${element.displayName}" parameter.',
      element: element,
    );
  }
}
