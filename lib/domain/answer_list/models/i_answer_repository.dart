import '../../question/models/question_id.dart';
import 'answer.dart';
import 'answer_id.dart';

abstract class IAnswerRepository {
  List<Answer> getByQuestionId(final QuestionId questionId);
  void incrementAnswerLike(final AnswerId answerId);
  void decrementAnswerLike(final AnswerId answerId);
  void evaluated(final AnswerId answerId);
}
