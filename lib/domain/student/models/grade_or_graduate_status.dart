enum GradeOrGraduateStatus {
  first('1年', 'first year'),
  second('2年', 'second year'),
  third('3年', 'third year'),
  graduate('既卒', 'graduate'),
  other('その他', 'other'),
  ;

  const GradeOrGraduateStatus(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
