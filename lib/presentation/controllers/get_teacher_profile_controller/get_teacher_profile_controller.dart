import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/application/di/teacher/get_teacher_profile_query_service.dart";

import "../../../application/teacher/application_service/get_teacher_profile_dto.dart";
import "../../../application/teacher/application_service/get_teacher_profile_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";

part "get_teacher_profile_controller.g.dart";

@riverpod
class GetTeacherProfileController extends _$GetTeacherProfileController {
  @override
  Future<GetTeacherProfileDto?> build(
    TeacherId teacherID,
  ) async {
    print("いくぞ");
    final getTeacherProfileQueryService =
        ref.watch(getTeacherProfileQueryServiceDiProvider);
    print("クエリ");
    final getTeacherProfileUseCase = GetTeacherProfileUseCase(
      teacherId: teacherID,
      queryService: getTeacherProfileQueryService,
    );
    print("ユースケース");

    final getTeacherProfileDto = getTeacherProfileUseCase.execute();
    print("excute");
    print("結果は、、{$getTeacherProfileDto}");
    return getTeacherProfileDto;
  }
}
