enum QuestionSubject {
  midMath('中学数学', 'mid-math'),
  midEng('中学英語', 'mid-eng'),
  highMath('高校数学', 'high-math'),
  highEng('高校英語', 'high-eng'),
  ;

  const QuestionSubject(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
