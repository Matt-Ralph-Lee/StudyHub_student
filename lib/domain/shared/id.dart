abstract class Id {
  final String _value;

  String get value;

  Id(this._value) {
    validate(_value);
  }

  void validate(final String value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Id) {
      return runtimeType == other.runtimeType && value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
