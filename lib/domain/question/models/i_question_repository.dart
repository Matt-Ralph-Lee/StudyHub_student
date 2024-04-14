import '../../student/models/student_id.dart';
import 'question.dart';
import 'question_id.dart';

abstract class IQuestionRepository {
  Future<void> save(final Question question);
  Future<void> delete(final QuestionId questionId);
  Future<Question?> findById(final QuestionId questionId);
  Future<QuestionId> generateId();
  Future<bool> checkIsMyQuestion({
    required final StudentId studentId,
    required final QuestionId questionId,
  });
  Future<void> resolveQuestion(final QuestionId questionId);
}
