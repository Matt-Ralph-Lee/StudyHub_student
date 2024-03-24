import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';

import '../../shared/session/session.dart';

class TeacherEvaluationAddUseCase {
  final Session _session;
  final ITeacherEvaluationRepository _repository;

  TeacherEvaluationAddUseCase({
    required final Session session,
    required final ITeacherEvaluationRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute({
    required final TeacherId to,
    required final int ratingData,
    required final String commentData,
  }) async {
    final from = _session.studentId;
    final rating = TeacherEvaluationRating(ratingData);
    final comment = TeacherEvaluationComment(commentData);

    final teacherEvaluation = TeacherEvaluation(
      from: from,
      to: to,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    await _repository.save(teacherEvaluation);
  }
}
