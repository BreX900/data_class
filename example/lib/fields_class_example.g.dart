// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields_class_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Father {
  Father get _self => this as Father;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Father &&
          runtimeType == other.runtimeType &&
          _self.child == other.child;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.child.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Father')..add('child', _self.child)).toString();
}

class FatherFields {
  const FatherFields([this._path = '']);

  final String _path;

  ChildFields get child => ChildFields('${_path}child.');

  @override
  String toString() => _path.isEmpty ? 'FatherFields()' : _path;
}

mixin _$Mother {
  Mother get _self => this as Mother;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mother &&
          runtimeType == other.runtimeType &&
          _self.child == other.child;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.child.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Mother')..add('child', _self.child)).toString();
}

class _MotherFields {
  // ignore: unused_element, unused_element_parameter
  const _MotherFields([this._path = '']);

  final String _path;

  ChildFields get child => ChildFields('$_path${_get('child')}.');

  @override
  String toString() => _path.isEmpty ? '_MotherFields()' : _path;

  String _get(String key) => _$MotherFieldMap[key]!;
}

mixin _$Child {
  Child get _self => this as Child;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Child &&
          runtimeType == other.runtimeType &&
          _self.id == other.id;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.id.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Child')..add('id', _self.id)).toString();
}

class ChildFields {
  const ChildFields([this._path = '']);

  final String _path;

  String get id => '$_path${_get('id')}';

  @override
  String toString() => _path.isEmpty ? 'ChildFields()' : _path;

  String _get(String key) => _$ChildFieldMap[key]!;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mother _$MotherFromJson(Map<String, dynamic> json) => Mother(
      child: Child.fromJson(json['myChild'] as Map<String, dynamic>),
    );

const _$MotherFieldMap = <String, String>{
  'child': 'myChild',
};

Map<String, dynamic> _$MotherToJson(Mother instance) => <String, dynamic>{
      'myChild': instance.child,
    };

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      id: (json['id'] as num).toInt(),
    );

const _$ChildFieldMap = <String, String>{
  'id': 'id',
};

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'id': instance.id,
    };
