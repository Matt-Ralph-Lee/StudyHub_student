enum QuestionPhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const QuestionPhotoFormat(this._value);
  String get value => _value;

  static final _formatsList =
      QuestionPhotoFormat.values.map((e) => e._value).toList();

  static final regExpString = _formatsList.join('|');
}
