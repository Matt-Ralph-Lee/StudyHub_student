import 'question_count.dart';

enum Status {
  beginner('beginner', 0),
  novice('novice', 3),
  advanced('advanced', 6),
  expert('expert', 9),
  ;

  const Status(this._english, this._minQuestionCount);

  final String _english;
  final int _minQuestionCount;

  String get english => _english;
  QuestionCount get minQuestionCount => QuestionCount(_minQuestionCount);
}
