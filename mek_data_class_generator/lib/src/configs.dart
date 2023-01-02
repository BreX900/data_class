import 'package:json_annotation/json_annotation.dart';

part 'configs.g.dart';

enum StringifyType { params, fields }

@JsonSerializable()
class Config {
  final int pageWidth;
  final bool comparable;
  final bool stringify;
  final StringifyType stringifyType;
  final bool copyable;
  final bool changeable;
  final bool changesVisible;
  final bool createFieldsClass;

  const Config({
    this.pageWidth = 80,
    this.comparable = true,
    this.stringify = true,
    this.stringifyType = StringifyType.params,
    this.copyable = false,
    this.changeable = false,
    this.changesVisible = false,
    this.createFieldsClass = false,
  });

  factory Config.fromJson(Map<String, dynamic> map) => _$ConfigFromJson(map);
}
