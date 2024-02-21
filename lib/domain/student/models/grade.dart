enum Grade {
  first('1年', 'first year'),
  second('2年', 'second year'),
  third('3年', 'third year'),
  other('その他', 'other'),
  ;

  const Grade(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
