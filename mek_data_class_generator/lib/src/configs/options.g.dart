// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map json) => $checkedCreate('Options', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'equatable',
      'stringify',
      'stringify_if_null',
      'buildable',
      'copyable',
      'changeable',
    ],
  );
  final val = Options(
    equatable: $checkedConvert('equatable', (v) => v as bool? ?? true),
    stringify: $checkedConvert('stringify', (v) => v as bool? ?? true),
    stringifyIfNull: $checkedConvert('stringify_if_null', (v) => v as bool? ?? true),
    buildable: $checkedConvert('buildable', (v) => v as bool? ?? false),
    copyable: $checkedConvert('copyable', (v) => v as bool? ?? false),
    changeable: $checkedConvert('changeable', (v) => v as bool? ?? false),
  );
  return val;
}, fieldKeyMap: const {'stringifyIfNull': 'stringify_if_null'});
