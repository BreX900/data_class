// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inheritance_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Animal {
  Animal get _self => this as Animal;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Animal &&
          runtimeType == other.runtimeType &&
          _self.finalField == other.finalField;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.finalField.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString('Animal')..add('finalField', _self.finalField)).toString();
  Animal copyWith({String? finalField});
  Animal change(void Function(_AnimalChanges c) updates);
  _AnimalChanges toChanges();
}

abstract class _AnimalChanges {
  _AnimalChanges._(Animal dc) : finalField = dc.finalField;

  String finalField;

  void update(void Function(_AnimalChanges c) updates);
  Animal build();
}

mixin _$Dog {
  Dog get _self => this as Dog;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          _self.finalField == other.finalField &&
          _self.getterField == other.getterField;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.finalField.hashCode);
    hashCode = $hashCombine(hashCode, _self.getterField.hashCode);
    return $hashFinish(hashCode);
  }

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

  Dog change(void Function(_DogChanges c) updates) =>
      (_DogChanges._(_self)..update(updates)).build();
  _DogChanges toChanges() => _DogChanges._(_self);
}

class _DogChanges implements _AnimalChanges {
  _DogChanges._(Dog dc)
      : finalField = dc.finalField,
        getterField = dc.getterField;

  @override
  String finalField;

  String getterField;

  @override
  void update(void Function(_DogChanges c) updates) => updates(this);
  @override
  Dog build() => Dog(
        finalField: finalField,
        getterField: getterField,
      );
}

mixin _$Cat {
  Cat get _self => this as Cat;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          _self.finalField == other.finalField &&
          _self.getterField == other.getterField;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.finalField.hashCode);
    hashCode = $hashCombine(hashCode, _self.getterField.hashCode);
    return $hashFinish(hashCode);
  }

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

  Cat change(void Function(_CatChanges c) updates) =>
      (_CatChanges._(_self)..update(updates)).build();
  _CatChanges toChanges() => _CatChanges._(_self);
}

class _CatChanges implements _AnimalChanges {
  _CatChanges._(Cat dc)
      : finalField = dc.finalField,
        getterField = dc.getterField;

  @override
  String finalField;

  String getterField;

  @override
  void update(void Function(_CatChanges c) updates) => updates(this);
  @override
  Cat build() => Cat(
        finalField: finalField,
        getterField: getterField,
      );
}
