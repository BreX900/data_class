import 'package:json_annotation/json_annotation.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'fields_class_example.g.dart';

@DataClass(createFieldsClass: true)
class Father with _$Father {
  static final fields = FatherFields();

  final Child child;

  const Father({
    required this.child,
  });
}

@DataClass(createFieldsClass: true)
@JsonSerializable(createFieldMap: true)
class Mother with _$Mother {
  static final fields = MotherFields();

  @JsonKey(name: 'myChild')
  final Child child;

  const Mother({
    required this.child,
  });

  factory Mother.fromJson(Map<String, dynamic> map) => _$MotherFromJson(map);
  Map<String, dynamic> toJson() => _$MotherToJson(this);
}

@DataClass(createFieldsClass: true)
@JsonSerializable(createFieldMap: true)
class Child with _$Child {
  static final fields = ChildFields();

  final int id;

  const Child({
    required this.id,
  });

  factory Child.fromJson(Map<String, dynamic> map) => _$ChildFromJson(map);
  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
