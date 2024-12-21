import 'package:json_annotation/json_annotation.dart';

part 'configs.g.dart';

enum StringifyType { params, fields }

@JsonSerializable()
class Config {
  final int? pageWidth;
  final bool comparable;
  final bool stringify;
  final StringifyType stringifyType;
  final bool stringifyIfNull;
  final bool buildable;
  final bool copyable;
  final bool changeable;
  final bool changesVisible;
  final bool createFieldsClass;
  final bool fieldsClassVisible;

  const Config({
    this.pageWidth,
    this.comparable = true,
    this.stringify = true,
    this.stringifyType = StringifyType.params,
    this.stringifyIfNull = true,
    this.buildable = false,
    this.copyable = false,
    this.changeable = false,
    this.changesVisible = false,
    this.createFieldsClass = false,
    this.fieldsClassVisible = true,
  });

  factory Config.fromJson(Map<String, dynamic> map) => _$ConfigFromJson(map);
}
