enum AnswerPhotoFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _value;
  const AnswerPhotoFormat(this._value);
  String get value => _value;
}

final answerPhotoFormatsList =
    AnswerPhotoFormat.values.map((e) => e._value).toList();

final answerPhotoFormatsRegExpString = answerPhotoFormatsList.join('|');
