enum ProfilePhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const ProfilePhotoFormat(this._value);
  String get value => _value;
}

final profilePhotoFormatsList =
    ProfilePhotoFormat.values.map((e) => e._value).toList();

final profilePhotoFormatsRegExpString = profilePhotoFormatsList.join('|');
