// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inheritance_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides, unused_element

mixin _$Animal {
  Animal get _self => this as Animal;

  Iterable<Object?> get _props sync* {
    yield _self.finalField;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Animal &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() =>
      (ClassToString('Animal')..add('finalField', _self.finalField)).toString();

  Animal copyWith({
    String? finalField,
  });

  Animal change(void Function(_AnimalChanges c) updates);

  _AnimalChanges toChanges();
}

abstract class _AnimalChanges {
  String finalField;

  _AnimalChanges._(Animal dc) : finalField = dc.finalField;

  void update(void Function(_AnimalChanges c) updates);

  Animal build();
}

mixin _$Dog {
  Dog get _self => this as Dog;

  Iterable<Object?> get _props sync* {
    yield _self.finalField;
    yield _self.getterField;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Dog &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

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

  Dog change(void Function(_DogChanges c) updates) =>
      (_DogChanges._(_self)..update(updates)).build();

  _DogChanges toChanges() => _DogChanges._(_self);
}

class _DogChanges implements _AnimalChanges {
  String finalField;
  String getterField;

  _DogChanges._(Dog dc)
      : finalField = dc.finalField,
        getterField = dc.getterField;

  void update(void Function(_DogChanges c) updates) => updates(this);

  Dog build() => Dog(
        finalField: finalField,
        getterField: getterField,
      );
}

mixin _$Cat {
  Cat get _self => this as Cat;

  Iterable<Object?> get _props sync* {
    yield _self.finalField;
    yield _self.getterField;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Cat &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

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

  Cat change(void Function(_CatChanges c) updates) =>
      (_CatChanges._(_self)..update(updates)).build();

  _CatChanges toChanges() => _CatChanges._(_self);
}

class _CatChanges implements _AnimalChanges {
  String finalField;
  String getterField;

  _CatChanges._(Cat dc)
      : finalField = dc.finalField,
        getterField = dc.getterField;

  void update(void Function(_CatChanges c) updates) => updates(this);

  Cat build() => Cat(
        finalField: finalField,
        getterField: getterField,
      );
}
