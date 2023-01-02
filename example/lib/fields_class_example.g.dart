// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields_class_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$Father {
  Father get _self => this as Father;

  Iterable<Object?> get _props sync* {
    yield _self.child;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Father &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() =>
      (ClassToString('Father')..add('child', _self.child)).toString();
}

class FatherFields {
  final String _path;

  const FatherFields([this._path = '']);

  ChildFields get child => ChildFields('${_path}child.');

  String toString() => _path.isEmpty ? 'FatherFields()' : _path;
}

mixin _$Mother {
  Mother get _self => this as Mother;

  Iterable<Object?> get _props sync* {
    yield _self.child;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mother &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() =>
      (ClassToString('Mother')..add('child', _self.child)).toString();
}

class MotherFields {
  final String _path;

  const MotherFields([this._path = '']);

  ChildFields get child => ChildFields('$_path${_get('child')}.');

  String toString() => _path.isEmpty ? 'MotherFields()' : _path;

  String _get(String key) => _$MotherFieldMap[key]!;
}

mixin _$Child {
  Child get _self => this as Child;

  Iterable<Object?> get _props sync* {
    yield _self.id;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Child &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Child')..add('id', _self.id)).toString();
}

class ChildFields {
  final String _path;

  const ChildFields([this._path = '']);

  String get id => '$_path${_get('id')}';

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
      id: json['id'] as int,
    );

const _$ChildFieldMap = <String, String>{
  'id': 'id',
};

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'id': instance.id,
    };
