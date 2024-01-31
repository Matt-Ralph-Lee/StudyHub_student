enum ProfilePhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const ProfilePhotoFormat(this._value);
  String get value => _value;

  static final _formatsList =
      ProfilePhotoFormat.values.map((e) => e._value).toList();

  static final regExpString = _formatsList.join('|');
}
