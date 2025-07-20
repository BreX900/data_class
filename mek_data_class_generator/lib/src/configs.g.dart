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
            'stringify_if_null',
            'buildable',
            'copyable',
            'changeable',
            'changes_visible',
            'create_fields_class',
            'fields_class_visible'
          ],
        );
        final val = Config(
          pageWidth: $checkedConvert('page_width', (v) => (v as num?)?.toInt()),
          comparable: $checkedConvert('comparable', (v) => v as bool? ?? true),
          stringify: $checkedConvert('stringify', (v) => v as bool? ?? true),
          stringifyType: $checkedConvert(
              'stringify_type',
              (v) =>
                  $enumDecodeNullable(_$StringifyTypeEnumMap, v) ??
                  StringifyType.params),
          stringifyIfNull:
              $checkedConvert('stringify_if_null', (v) => v as bool? ?? true),
          buildable: $checkedConvert('buildable', (v) => v as bool? ?? false),
          copyable: $checkedConvert('copyable', (v) => v as bool? ?? false),
          changeable: $checkedConvert('changeable', (v) => v as bool? ?? false),
          changesVisible:
              $checkedConvert('changes_visible', (v) => v as bool? ?? false),
          createFieldsClass: $checkedConvert(
              'create_fields_class', (v) => v as bool? ?? false),
          fieldsClassVisible: $checkedConvert(
              'fields_class_visible', (v) => v as bool? ?? true),
        );
        return val;
      },
      fieldKeyMap: const {
        'pageWidth': 'page_width',
        'stringifyType': 'stringify_type',
        'stringifyIfNull': 'stringify_if_null',
        'changesVisible': 'changes_visible',
        'createFieldsClass': 'create_fields_class',
        'fieldsClassVisible': 'fields_class_visible'
      },
    );

const _$StringifyTypeEnumMap = {
  StringifyType.params: 'params',
  StringifyType.fields: 'fields',
};
