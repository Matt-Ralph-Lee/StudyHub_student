abstract class PhotoPath {
  final String _value;

  String get value => _value;

  PhotoPath(this._value) {
    validate(_value);
  }

  void validate(final String value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is PhotoPath) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
