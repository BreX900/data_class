import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable()
class Options {
  final Object? runOnlyIfTriggered;
  final bool equatable;
  final bool stringify;
  final bool stringifyIfNull;
  final bool buildable;
  final bool copyable;
  final bool changeable;

  const Options({
    this.runOnlyIfTriggered,
    this.equatable = true,
    this.stringify = true,
    this.stringifyIfNull = true,
    this.buildable = false,
    this.copyable = false,
    this.changeable = false,
  });

  factory Options.fromJson(Map<String, dynamic> map) => _$OptionsFromJson(map);
}
