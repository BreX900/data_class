// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_cases.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$$Dollar {
  $Dollar get _self => this as $Dollar;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is $Dollar &&
          runtimeType == other.runtimeType &&
          _self.$dollar == other.$dollar;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.$dollar.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() =>
      (ClassToString(r'$Dollar')..add(r'$dollar', _self.$dollar)).toString();
  $Dollar copyWith({$Dollar? $dollar}) {
    return $Dollar(
      $dollar: $dollar ?? _self.$dollar,
    );
  }

  $Dollar change(void Function(_$DollarChanges c) updates) =>
      (_$DollarChanges._(_self)..update(updates)).build();
  _$DollarChanges toChanges() => _$DollarChanges._(_self);
}

class $DollarBuilder {
  $Dollar? $dollar;

  void update(void Function($DollarBuilder b) updates) => updates(this);

  $Dollar build() => $Dollar(
        $dollar: $dollar!,
      );

  void replace($Dollar other) {
    $dollar = other.$dollar;
  }
}

class _$DollarChanges {
  _$DollarChanges._($Dollar dc) : $dollar = dc.$dollar;

  $Dollar $dollar;

  void update(void Function(_$DollarChanges c) updates) => updates(this);

  $Dollar build() => $Dollar(
        $dollar: $dollar,
      );
}
