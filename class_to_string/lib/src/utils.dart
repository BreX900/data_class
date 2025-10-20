extension WriteValueStringBuggerExtension on StringBuffer {
  void writeValue(Object? value) {
    switch (value) {
      case String():
        write("'");
        write(value);
        write("'");

      case null:
      case num():
      case bool():
      default:
        write(value);
    }
  }
}
