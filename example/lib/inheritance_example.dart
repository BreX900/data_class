import 'package:mek_data_class/mek_data_class.dart';

part 'inheritance_example.g.dart';

@DataClass(changeable: true, copyable: true)
abstract class Animal with _$Animal {
  final String finalField;
  String get getterField;

  const Animal({
    required this.finalField,
  });

  String get name;

  String say();
}

@DataClass(changeable: true, copyable: true)
class Dog extends Animal with Action, _$Dog {
  @override
  final String getterField;

  Dog({
    required String finalField,
    required this.getterField,
  }) : super(finalField: finalField);

  @override
  final String name = 'Dog';

  @override
  String say() => 'Woof!';
}

@DataClass(changeable: true, copyable: true)
class Cat extends Animal with Action, _$Cat {
  @override
  final String getterField;

  Cat({
    required String finalField,
    required this.getterField,
  }) : super(finalField: finalField);

  @override
  final String name = 'Cat';

  @override
  String say() => 'Meow!';
}

mixin Action {
  String get name;

  String say();

  String get action => '$name say ${say()}';
}
