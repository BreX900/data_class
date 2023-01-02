// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map json) => $checkedCreate(
      'Config',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'page_width',
            'comparable',
            'stringify',
            'stringify_type',
            'copyable',
            'changeable',
            'changes_visible',
            'create_fields_class'
          ],
        );
        final val = Config(
          pageWidth: $checkedConvert('page_width', (v) => v as int? ?? 80),
          comparable: $checkedConvert('comparable', (v) => v as bool? ?? true),
          stringify: $checkedConvert('stringify', (v) => v as bool? ?? true),
          stringifyType: $checkedConvert(
              'stringify_type',
              (v) =>
                  $enumDecodeNullable(_$StringifyTypeEnumMap, v) ??
                  StringifyType.params),
          copyable: $checkedConvert('copyable', (v) => v as bool? ?? false),
          changeable: $checkedConvert('changeable', (v) => v as bool? ?? false),
          changesVisible:
              $checkedConvert('changes_visible', (v) => v as bool? ?? false),
          createFieldsClass: $checkedConvert(
              'create_fields_class', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'pageWidth': 'page_width',
        'stringifyType': 'stringify_type',
        'changesVisible': 'changes_visible',
        'createFieldsClass': 'create_fields_class'
      },
    );

const _$StringifyTypeEnumMap = {
  StringifyType.params: 'params',
  StringifyType.fields: 'fields',
};
