enum Grade {
  juniorHighFirst('中学1年', 'first year of junior high school'),
  juniorHighSecond('中学2年', 'second year of junior high school'),
  juniorHighThird('中学3年', 'third year of junior high school'),
  highFirst('高校1年', 'first year of high school'),
  highFSecond('高校2年', 'second year of high school'),
  highThird('高校3年', 'third year of high school'),
  other('その他', 'other'),
  ;

  const Grade(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
