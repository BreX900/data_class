// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inheritance_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Animal {
  Animal get _self => this as Animal;

  List<Object?> get _props => [
        _self.finalField,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Animal &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() =>
      (ClassToString('Animal')..add('finalField', _self.finalField)).toString();

  Animal copyWith({
    String? finalField,
  });

  Animal change(void Function(AnimalChanges c) updates);

  AnimalChanges toChanges();
}

abstract class AnimalChanges {
  String get finalField;

  Animal build();
}

mixin _$Dog {
  Dog get _self => this as Dog;

  List<Object?> get _props => [
        _self.finalField,
        _self.getterField,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Dog &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('Dog')
        ..add('finalField', _self.finalField)
        ..add('getterField', _self.getterField))
      .toString();

  Dog copyWith({
    String? finalField,
    String? getterField,
  }) {
    return Dog(
      finalField: finalField ?? _self.finalField,
      getterField: getterField ?? _self.getterField,
    );
  }

  Dog change(void Function(_DogChanges c) updates) {
    final changes = _DogChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _DogChanges toChanges() => _DogChanges._(_self);
}

class _DogChanges implements AnimalChanges {
  String finalField;
  String getterField;

  _DogChanges._(Dog self)
      : finalField = self.finalField,
        getterField = self.getterField;

  Dog build() => Dog(
        finalField: finalField,
        getterField: getterField,
      );
}

mixin _$Cat {
  Cat get _self => this as Cat;

  List<Object?> get _props => [
        _self.finalField,
        _self.getterField,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Cat &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('Cat')
        ..add('finalField', _self.finalField)
        ..add('getterField', _self.getterField))
      .toString();

  Cat copyWith({
    String? finalField,
    String? getterField,
  }) {
    return Cat(
      finalField: finalField ?? _self.finalField,
      getterField: getterField ?? _self.getterField,
    );
  }

  Cat change(void Function(_CatChanges c) updates) {
    final changes = _CatChanges._(_self);
    updates(changes);
    return changes.build();
  }

  _CatChanges toChanges() => _CatChanges._(_self);
}

class _CatChanges implements AnimalChanges {
  String finalField;
  String getterField;

  _CatChanges._(Cat self)
      : finalField = self.finalField,
        getterField = self.getterField;

  Cat build() => Cat(
        finalField: finalField,
        getterField: getterField,
      );
}
