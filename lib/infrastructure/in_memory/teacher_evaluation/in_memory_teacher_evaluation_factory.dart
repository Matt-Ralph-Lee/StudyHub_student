import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_factory.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';

class InMemoryTeacherEvaluationFactory implements ITeacherEvaluationFactory {
  final ITeacherEvaluationRepository _repository;

  InMemoryTeacherEvaluationFactory(
      final ITeacherEvaluationRepository repository)
      : _repository = repository;

  @override
  Future<TeacherEvaluation> createTeacherEvaluation({
    required StudentId from,
    required TeacherId to,
    required TeacherEvaluationRating rating,
    required TeacherEvaluationComment comment,
    required DateTime createdAt,
  }) async {
    final teacherEvaluationId = await _repository.generateId(to);

    return TeacherEvaluation(
        id: teacherEvaluationId,
        from: from,
        to: to,
        rating: rating,
        comment: comment,
        createdAt: createdAt);
  }
}
