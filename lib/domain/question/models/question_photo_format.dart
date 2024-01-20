enum QuestionPhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const QuestionPhotoFormat(this._value);
  String get value => _value;
}

final questionPhotoFormatsList =
    QuestionPhotoFormat.values.map((e) => e._value).toList();

final questionPhotoFormatsRegExpString = questionPhotoFormatsList.join('|');
