enum Gender {
  male('男性', 'male'),
  female('女性', 'female'),
  other('その他', 'other'),
  noAnswer('回答しない', 'non-answer'),
  ;

  const Gender(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
