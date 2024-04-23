import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/teacher/get_teacher_profile_query_service.dart";
import "../../../application/teacher/application_service/get_teacher_profile_dto.dart";
import "../../../application/teacher/application_service/get_teacher_profile_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";

part "get_teacher_profile_controller.g.dart";

@riverpod
class GetTeacherProfileController extends _$GetTeacherProfileController {
  @override
  Future<GetTeacherProfileDto?> build(final TeacherId teacherId) async {
    final getTeacherProfileQueryService =
        ref.watch(getTeacherProfileQueryServiceDiProvider);
    final logger = ref.read(loggerDiProvider);
    final getTeacherProfileUseCase = GetTeacherProfileUseCase(
      queryService: getTeacherProfileQueryService,
      logger: logger,
    );

    final getTeacherProfileDto = getTeacherProfileUseCase.execute(teacherId);
    return getTeacherProfileDto;
  }
}
