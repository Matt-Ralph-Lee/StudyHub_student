enum ReportReason {
  answerIrrelevant('回答が質問内容に関係ない', 'The answer is irrelevant to the question'),
  answerIncorrect('回答が正しくない', 'The answer is incorrect'),
  answerOffensive('回答が誹謗中傷や差別的な表現を含んでいる',
      'The answer contains offensive or discriminatory content'),

  userSpam('スパムである', 'It is spam.'),
  userImpersonation('なりすましをしている', 'It is impersonation.'),

  other('その他', 'other'),
  ;

  const ReportReason(this._japanese, this._english);

  final String _japanese;
  final String _english;

  String get japanese => _japanese;
  String get english => _english;
}
