import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';
import '../../interfaces/i_logger.dart';
import 'get_teacher_evaluation_dto.dart';

class GetTeacherEvaluationUseCase {
  final ITeacherEvaluationRepository _repository;
  final ILogger _logger;

  GetTeacherEvaluationUseCase({
    required final ITeacherEvaluationRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<List<GetTeacherEvaluationDto>> execute(
      final TeacherId teacherId) async {
    _logger.info('BEGIN $GetTeacherEvaluationUseCase.execute()');

    final teacherEvaluationList = await _repository.getByTeacherId(teacherId);

    List<GetTeacherEvaluationDto> teacherEvaluationDtoList = [];

    for (final teacherEvaluation in teacherEvaluationList) {
      teacherEvaluationDtoList.add(
        GetTeacherEvaluationDto(
            from: teacherEvaluation.from,
            to: teacherEvaluation.to,
            rating: teacherEvaluation.rating.value,
            comment: teacherEvaluation.comment.value,
            createdAt: teacherEvaluation.createdAt),
      );
    }

    _logger.info('END $GetTeacherEvaluationUseCase.execute()');
    return teacherEvaluationDtoList;
  }
}
