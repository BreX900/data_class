// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inheritance_example.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$Animal {
  Animal copyWith({$Parameter<String> finalField = const Unspecified()});
  Animal change(void Function(AnimalChanges c) updates);
  AnimalChanges toChanges();
}

abstract class AnimalChanges {
  AnimalChanges._(this._original);

  final Animal _original;

  late String finalField = _original.finalField;

  void update(void Function(AnimalChanges c) updates);
  Animal build();
}

mixin _$Dog {
  Dog get _self => this as Dog;
  Dog copyWith({
    $Parameter<String> finalField = const Unspecified(),
    $Parameter<String> getterField = const Unspecified(),
  }) {
    return Dog(
      finalField: Unspecified.resolve(_self.finalField, finalField),
      getterField: Unspecified.resolve(_self.getterField, getterField),
    );
  }

  Dog change(void Function(DogChanges c) updates) =>
      (toChanges()..update(updates)).build();
  DogChanges toChanges() => DogChanges._(_self);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog &&
          runtimeType == other.runtimeType &&
          _self.getterField == other.getterField &&
          _self.name == other.name &&
          _self.finalField == other.finalField;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.getterField.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.finalField.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Dog')
        ..add('getterField', _self.getterField)
        ..add('name', _self.name)
        ..add('finalField', _self.finalField))
      .toString();
}

class DogChanges implements AnimalChanges {
  DogChanges._(this._original);

  @override
  final Dog _original;

  @override
  late String finalField = _original.finalField;

  late String getterField = _original.getterField;

  @override
  void update(void Function(DogChanges c) updates) => updates(this);

  @override
  Dog build() {
    return Dog(
      finalField: finalField,
      getterField: getterField,
    );
  }
}

mixin _$Cat {
  Cat get _self => this as Cat;
  Cat copyWith({
    $Parameter<String> finalField = const Unspecified(),
    $Parameter<String> getterField = const Unspecified(),
  }) {
    return Cat(
      finalField: Unspecified.resolve(_self.finalField, finalField),
      getterField: Unspecified.resolve(_self.getterField, getterField),
    );
  }

  Cat change(void Function(CatChanges c) updates) =>
      (toChanges()..update(updates)).build();
  CatChanges toChanges() => CatChanges._(_self);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cat &&
          runtimeType == other.runtimeType &&
          _self.getterField == other.getterField &&
          _self.name == other.name &&
          _self.finalField == other.finalField;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.getterField.hashCode);
    hashCode = $hashCombine(hashCode, _self.name.hashCode);
    hashCode = $hashCombine(hashCode, _self.finalField.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString('Cat')
        ..add('getterField', _self.getterField)
        ..add('name', _self.name)
        ..add('finalField', _self.finalField))
      .toString();
}

class CatChanges implements AnimalChanges {
  CatChanges._(this._original);

  @override
  final Cat _original;

  @override
  late String finalField = _original.finalField;

  late String getterField = _original.getterField;

  @override
  void update(void Function(CatChanges c) updates) => updates(this);

  @override
  Cat build() {
    return Cat(
      finalField: finalField,
      getterField: getterField,
    );
  }
}
