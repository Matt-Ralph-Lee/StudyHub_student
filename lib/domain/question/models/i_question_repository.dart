import 'question.dart';
import 'question_id.dart';

abstract class IQuestionRepository {
  Future<void> save(final Question question);
  Future<void> delete(final QuestionId questionId);
  Future<Question?> findById(final QuestionId questionId);
  Future<QuestionId> generateId();
}
