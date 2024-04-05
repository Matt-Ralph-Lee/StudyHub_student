import 'get_teacher_evaluation_dto.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';

class GetTeacherEvaluationUseCase {
  final ITeacherEvaluationRepository _repository;

  GetTeacherEvaluationUseCase({
    required final ITeacherEvaluationRepository repository,
  }) : _repository = repository;

  Future<List<GetTeacherEvaluationDto>> execute(
      final TeacherId teacherId) async {
    final teacherEvaluationList = await _repository.getByTeacherId(teacherId);
    if (teacherEvaluationList == null) return [];

    List<GetTeacherEvaluationDto> teacherEvaluationDtoList = [];

    for (final TeacherEvaluation teacherEvaluation in teacherEvaluationList) {
      teacherEvaluationDtoList.add(
        GetTeacherEvaluationDto(
            from: teacherEvaluation.from,
            to: teacherEvaluation.to,
            rating: teacherEvaluation.rating.value,
            comment: teacherEvaluation.comment.value,
            createdAt: teacherEvaluation.createdAt),
      );
    }

    return teacherEvaluationDtoList;
  }
}
