enum EnrollmentStatus {
  enrolled('在籍', 'enrolled'),
  graduated('卒業', 'graduated'),
  noAnswer('回答なし', 'no answer'),
  ;

  const EnrollmentStatus(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
