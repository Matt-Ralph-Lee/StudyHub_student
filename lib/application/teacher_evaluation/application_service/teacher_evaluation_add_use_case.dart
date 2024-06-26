import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/teacher/models/i_teacher_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_factory.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';

class TeacherEvaluationAddUseCase {
  final Session _session;
  final ITeacherEvaluationRepository _repository;
  final ITeacherEvaluationFactory _factory;
  final IAnswerRepository _answerRepository;
  final ITeacherRepository _teacherRepository;
  final ILogger _logger;

  TeacherEvaluationAddUseCase({
    required final Session session,
    required final ITeacherEvaluationRepository repository,
    required final ITeacherEvaluationFactory factory,
    required final IAnswerRepository answerRepository,
    required final ITeacherRepository teacherRepository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _factory = factory,
        _answerRepository = answerRepository,
        _teacherRepository = teacherRepository,
        _logger = logger;

  Future<void> execute({
    required final AnswerId answerId,
    required final QuestionId questionId,
    required final TeacherId to,
    required final int ratingData,
    required final String commentData,
  }) async {
    _logger.info('BEGIN $TeacherEvaluationAddUseCase.execute()');

    final from = _session.studentId;
    final rating = TeacherEvaluationRating(ratingData);
    final comment = TeacherEvaluationComment(commentData);

    final teacherEvaluation = await _factory.createTeacherEvaluation(
      from: from,
      to: to,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    await _repository.save(teacherEvaluation);

    await _answerRepository.evaluated(
        answerId: answerId, questionId: questionId);

    await _teacherRepository.changeRate(teacherEvaluation);

    _logger.info('END $TeacherEvaluationAddUseCase.execute()');
  }
}
