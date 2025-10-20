import 'dart:async';

import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_data_class_generator/src/configs/options.dart';
import 'package:mek_data_class_generator/src/helpers/builder_helper.dart';
import 'package:mek_data_class_generator/src/helpers/change_helper.dart';
import 'package:mek_data_class_generator/src/helpers/copy_with_helper.dart';
import 'package:mek_data_class_generator/src/helpers/equatable_helper.dart';
import 'package:mek_data_class_generator/src/helpers/helper_core.dart';
import 'package:mek_data_class_generator/src/helpers/to_string_helper.dart';
import 'package:source_gen/source_gen.dart' hide LibraryBuilder;
import 'package:source_helper/source_helper.dart';

class DataClassGenerator extends GeneratorForAnnotation<DataClass> {
  static final DartEmitter _dartEmitter = DartEmitter(useNullSafetySyntax: true);

  final Options options;

  DataClassGenerator({required this.options});

  @override
  Future<String?> generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement2) return null;

    final library = _createLibrary(element);

    return '${library.accept(_dartEmitter)}';
  }

  Library _createLibrary(ClassElement2 element) {
    final registry = _RegistryHelper(options: options, element: element);

    registry.register();

    return registry.createLibrary();
  }
}

class _RegistryHelper extends HelperCore
    with CopyWithHelper, ChangeHelper, BuilderHelper, EquatableHelper, ToStringHelper {
  final _libraryBody = <Spec>[];
  final _mixinMethods = <Method>[];
  var _shouldCreateSelfMixinGetter = false;

  List<Spec> get libraryBody => _libraryBody;

  _RegistryHelper({required super.options, required super.element});

  @override
  void registerMixinMethod(Method method) => _mixinMethods.add(method);

  @override
  void registerClass(Class class$) => _libraryBody.add(class$);

  @override
  void registerMixinSelfGetter() => _shouldCreateSelfMixinGetter = true;

  Library createLibrary() {
    return Library((b) => b
      ..body.add(_createMixin())
      ..body.addAll(_libraryBody));
  }

  Mixin _createMixin() {
    Method? selfMethod;
    if (_shouldCreateSelfMixinGetter) {
      selfMethod = Method((b) => b
        ..returns = Reference(element.thisType.getDisplayString())
        ..type = MethodType.getter
        ..name = '_self'
        ..lambda = true
        ..body = Code('this as ${element.thisType.getDisplayString()}'));
    }

    return Mixin((b) => b
      ..name = '_\$${element.displayName.nonPrivate}'
      ..types.addAll(element.typeParameters2.map((e) => Reference(e.displayString2())))
      ..methods.addAll([if (selfMethod != null) selfMethod])
      ..methods.addAll(_mixinMethods));
  }
}
