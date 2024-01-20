import 'answer.dart';

class AnswerList {
  final List<Answer> _answerList;

  List<Answer> get answerList => _answerList;

  AnswerList({
    required final List<Answer> answerList,
  }) : _answerList = answerList;

// 以下はstudentアプリでは必要ないと判断
  // void addAnswer(final Answer newAnswer) {
  //   _answerList.add(newAnswer);
  // }

  // void deleteAnswer(final Answer targetAnswer) {
  //   _answerList
  //       .removeWhere((answer) => answer.answerId == targetAnswer.answerId);
  // }
}
