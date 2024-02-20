enum GraduateStatus {
  graduate('既卒', 'graduate'),
  other('その他', 'other'),
  ;

  const GraduateStatus(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
