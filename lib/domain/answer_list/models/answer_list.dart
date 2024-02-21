import '../exception/answer_domain_exception.dart';
import '../exception/answer_domain_exception_detail.dart';

import 'answer.dart';

class AnswerList extends Iterable {
  final List<Answer> _answerList;

  List<Answer> get answerList => _answerList;

  AnswerList(this._answerList);

  @override
  Iterator get iterator => _answerList.iterator;

  Answer getMostLikedAnswer() {
    if (_answerList.isEmpty) {
      throw const AnswerDomainException(AnswerDomainExceptionDetail.noAnswer);
    }
    Answer mostLikedAnswer = _answerList[0];
    for (final answer in _answerList) {
      if (mostLikedAnswer.like > answer.like) {
        mostLikedAnswer = answer;
      }
    }

    return mostLikedAnswer;
  }

// 以下はstudentアプリでは必要ないと判断
  // void addAnswer(final Answer newAnswer) {
  //   _answerList.add(newAnswer);
  // }

  // void deleteAnswer(final Answer targetAnswer) {
  //   _answerList
  //       .removeWhere((answer) => answer.answerId == targetAnswer.answerId);
  // }
}
