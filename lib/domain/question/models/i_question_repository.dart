import 'question.dart';
import 'question_id.dart';

abstract class IQuestionRepository {
  void save(final Question question);
  void delete(final QuestionId questionId);
  Question? findById(final QuestionId questionId);
  QuestionId generateId();
}
