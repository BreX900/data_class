class Config {
  final int pageWidth;
  final bool comparable;
  final bool stringify;
  final bool copyable;
  final bool changeable;
  final bool changesVisible;

  const Config({
    required this.pageWidth,
    required this.comparable,
    required this.copyable,
    required this.stringify,
    required this.changeable,
    required this.changesVisible,
  });

  factory Config.from(Map<String, dynamic> map) {
    return Config(
      pageWidth: map['pageWidth'] ?? 80,
      comparable: map['comparable'] ?? true,
      stringify: map['stringify'] ?? true,
      copyable: map['copyable'] ?? false,
      changeable: map['changeable'] ?? false,
      changesVisible: map['changesVisible'] ?? false,
    );
  }
}
