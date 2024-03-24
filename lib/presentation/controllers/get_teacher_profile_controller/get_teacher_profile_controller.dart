import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/teacher/application_service/get_teacher_profile_dto.dart";
import "../../../application/teacher/application_service/get_teacher_profile_use_case.dart";
import "../../../application/teacher/application_service/i_get_teacher_profile_query_service.dart";
import "../../../domain/teacher/models/teacher_id.dart";

part "get_teacher_profile_controller.g.dart";

@riverpod
class GetTeacherProfileController extends _$GetTeacherProfileController {
  @override
  Future<GetTeacherProfileDto?> build(
    TeacherId teacherID,
    IGetTeacherProfileQueryService iGetTeacherProfileQueryService,
  ) async {
    final session = ref.watch(sessionDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getTeacherProfileUseCase = GetTeacherProfileUseCase(
      teacherId: teacherID,
      queryService: iGetTeacherProfileQueryService,
    );

    final getTeacherProfileDto = getTeacherProfileUseCase.execute();
    return getTeacherProfileDto;
  }
}
