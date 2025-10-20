// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_cases.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

mixin _$$Dollar {
  $Dollar get _self => this as $Dollar;
  $Dollar copyWith({
    $Parameter<$Dollar> $dollar = const Unspecified(),
    $Parameter<$Dollar?> euro = const Unspecified(),
    $Parameter<String> privateAndPublic = const Unspecified(),
    $Parameter<String> private = const Unspecified(),
  }) {
    return $Dollar(
      $dollar: Unspecified.resolve(_self.$dollar, $dollar),
      euro: Unspecified.resolve(_self.euro, euro),
      privateAndPublic:
          Unspecified.resolve(_self.privateAndPublic, privateAndPublic),
      private: Unspecified.resolve(_self._private, private),
    );
  }

  $Dollar change(void Function($DollarChanges c) updates) =>
      (toChanges()..update(updates)).build();
  $DollarChanges toChanges() => $DollarChanges._(_self);
  $Dollar rebuild(void Function($DollarBuilder b) updates) =>
      (toBuilder()..update(updates)).build();
  $DollarBuilder toBuilder() => $DollarBuilder()..replace(_self);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is $Dollar &&
          runtimeType == other.runtimeType &&
          _self.$dollar == other.$dollar &&
          _self.euro == other.euro &&
          _self._privateAndPublic == other._privateAndPublic &&
          _self._private == other._private;
  @override
  int get hashCode {
    var hashCode = 0;
    hashCode = $hashCombine(hashCode, _self.$dollar.hashCode);
    hashCode = $hashCombine(hashCode, _self.euro.hashCode);
    hashCode = $hashCombine(hashCode, _self._privateAndPublic.hashCode);
    hashCode = $hashCombine(hashCode, _self._private.hashCode);
    return $hashFinish(hashCode);
  }

  @override
  String toString() => (ClassToString(r'$Dollar')
        ..add(r'$dollar', _self.$dollar)
        ..add('euro', _self.euro)
        ..add('_privateAndPublic', _self._privateAndPublic)
        ..add('_private', _self._private))
      .toString();
}

class $DollarChanges {
  $DollarChanges._(this._original);

  final $Dollar _original;

  late $DollarChanges $dollar = _original.$dollar.toChanges();

  late $DollarChanges? euro = _original.euro?.toChanges();

  late String privateAndPublic = _original.privateAndPublic;

  late String private = _original._private;

  void update(void Function($DollarChanges c) updates) => updates(this);

  $Dollar build() {
    return $Dollar(
      $dollar: $dollar.build(),
      euro: euro?.build(),
      privateAndPublic: privateAndPublic,
      private: private,
    );
  }
}

class $DollarBuilder {
  $DollarBuilder $dollar = $DollarBuilder();

  $DollarBuilder? euro;

  String? privateAndPublic;

  String? private;

  void update(void Function($DollarBuilder b) updates) => updates(this);

  $Dollar build() {
    return $Dollar(
      $dollar: $dollar.build(),
      euro: euro?.build(),
      privateAndPublic:
          ArgumentError.checkNotNull(privateAndPublic, 'privateAndPublic'),
      private: ArgumentError.checkNotNull(private, 'private'),
    );
  }

  void replace(covariant $Dollar other) {
    $dollar = other.$dollar.toBuilder();
    euro = other.euro?.toBuilder();
    privateAndPublic = other.privateAndPublic;
    private = other._private;
  }
}
