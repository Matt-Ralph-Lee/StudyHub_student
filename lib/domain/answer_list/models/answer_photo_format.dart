enum AnswerPhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const AnswerPhotoFormat(this._value);
  String get value => _value;

  static final _formatsList =
      AnswerPhotoFormat.values.map((e) => e._value).toList();

  static final regExpString = _formatsList.join('|');
}
