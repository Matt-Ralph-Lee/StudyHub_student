enum ProfileImageFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const ProfileImageFormat(this._value);
  String get value => _value;
}

final profileImageFormatsList =
    ProfileImageFormat.values.map((e) => e._value).toList();

final profileImageFormatsRegExpString = profileImageFormatsList.join('|');
