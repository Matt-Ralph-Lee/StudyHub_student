import '../../question/models/question_id.dart';
import 'answer.dart';
import 'answer_id.dart';

abstract class IAnswerRepository {
  Future<List<Answer>> getByQuestionId(final QuestionId questionId);
  Future<void> incrementAnswerLike({
    required final AnswerId answerId,
    required final QuestionId questionId,
  });
  Future<void> decrementAnswerLike({
    required final AnswerId answerId,
    required final QuestionId questionId,
  });
  Future<void> evaluated({
    required final AnswerId answerId,
    required final QuestionId questionId,
  });
}
