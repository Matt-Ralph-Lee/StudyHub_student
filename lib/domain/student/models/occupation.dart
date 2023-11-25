enum Occupation {
  student('学生', 'student'),
  companyEmployee('会社員', 'company employee'),
  teacher('教師', 'teacher'),
  others('その他', 'others'),
  ;

  const Occupation(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
