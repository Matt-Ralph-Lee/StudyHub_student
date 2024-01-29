enum SchoolType {
  juniorHighSchool('中学校', 'junior high school'),
  highSchool('高校', 'high school'),
  universtiy('大学', 'university'),
  ;

  const SchoolType(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
