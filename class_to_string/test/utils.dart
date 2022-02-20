class FakeClass {
  final Object Function() _toString;

  FakeClass(this._toString);

  @override
  String toString() => _toString().toString();
}
