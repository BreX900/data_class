import 'package:mek_data_class/mek_data_class.dart';

part 'edge_cases.g.dart';

@DataClass(changeable: true, buildable: true, copyable: true)
class $Dollar with _$$Dollar {
  final $Dollar $dollar;
  final $Dollar? euro;
  final String _privateAndPublic;
  final String _private;

  String get privateAndPublic => _privateAndPublic;

  const $Dollar({
    required this.$dollar,
    required this.euro,
    required String privateAndPublic,
    required String private,
  })  : _privateAndPublic = privateAndPublic,
        _private = private;
}
