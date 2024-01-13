class SchoolName {
  final String _value;

  String get value => _value;

  SchoolName(this._value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is SchoolName) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
