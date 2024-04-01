import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';

import '../../shared/session/session.dart';

class TeacherEvaluationAddUseCase {
  final Session _session;
  final ITeacherEvaluationRepository _repository;
  final IAnswerRepository _answerRepository;

  TeacherEvaluationAddUseCase({
    required final Session session,
    required final ITeacherEvaluationRepository repository,
    required final IAnswerRepository answerRepository,
  })  : _session = session,
        _repository = repository,
        _answerRepository = answerRepository;

  Future<void> execute({
    required final AnswerId answerId,
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

    _answerRepository.evaluated(answerId);
  }
}
