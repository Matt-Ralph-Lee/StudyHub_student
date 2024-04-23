import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import '../../../application/di/teacher_evaluation/repository/teacher_evaluation_repository_provider.dart';
import "../../../application/teacher_evaluation/application_service/get_teacher_evaluation_dto.dart";
import "../../../application/teacher_evaluation/application_service/get_teacher_evaluation_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";

part "get_teacher_evaluation_controller.g.dart";

@riverpod
class GetTeacherEvaluationController extends _$GetTeacherEvaluationController {
  @override
  Future<List<GetTeacherEvaluationDto>> build(final TeacherId teacherId) async {
    final teacherEvaluationRepository =
        ref.read(teacherEvaluationRepositoryDiProvider);
    final logger = ref.read(loggerDiProvider);
    final getTeacherEvaluationUseCase = GetTeacherEvaluationUseCase(
      repository: teacherEvaluationRepository,
      logger: logger,
    );

    final questionCardDto = getTeacherEvaluationUseCase.execute(teacherId);
    return questionCardDto;
  }
}
