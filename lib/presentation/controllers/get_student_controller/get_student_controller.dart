import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_provider.dart";
import "../../../application/student/application_service/get_student_dto.dart";
import "../../../application/student/application_service/get_student_use_case.dart";
import "../../../domain/student/models/student_id.dart";

part "get_student_controller.g.dart";

@riverpod
class GetStudentController extends _$GetStudentController {
  @override
  Future<GetStudentDto> build(
    StudentId studentId,
  ) async {
    final getStudentRepository = ref.watch(studentRepositoryDiProvider);
    final session = ref.watch(nonNullSessionProvider);

    final getStudentUseCase =
        GetStudentUseCase(repository: getStudentRepository, session: session);

    final getStudentDto = getStudentUseCase.execute();
    return getStudentDto;
  }
}
