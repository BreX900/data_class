import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable()
class Options {
  final Object? runOnlyIfTriggered;
  @JsonKey(defaultValue: true)
  final bool equatable;
  @JsonKey(defaultValue: true)
  final bool stringify;
  @JsonKey(defaultValue: true)
  final bool stringifyIfNull;
  @JsonKey(defaultValue: false)
  final bool buildable;
  @JsonKey(defaultValue: false)
  final bool copyable;
  @JsonKey(defaultValue: false)
  final bool mergeable;
  @JsonKey(defaultValue: false)
  final bool changeable;

  const Options({
    required this.runOnlyIfTriggered,
    required this.equatable,
    required this.stringify,
    required this.stringifyIfNull,
    required this.buildable,
    required this.copyable,
    required this.mergeable,
    required this.changeable,
  });

  factory Options.fromJson(Map<String, dynamic> map) => _$OptionsFromJson(map);
}
