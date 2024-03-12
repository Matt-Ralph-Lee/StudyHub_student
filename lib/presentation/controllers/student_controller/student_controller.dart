import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_repository_provider.dart";
import "../../../application/student/application_service/get_student_dto.dart";
import "../../../application/student/application_service/get_student_use_case.dart";

part "student_controller.g.dart";

@riverpod
class StudentController extends _$StudentController {
  @override
  Future<GetStudentDto> build() async {
    final session = ref.watch(sessionDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getStudentUseCase = GetStudentUseCase(
      session: session,
      repository: ref.watch(studentRepositoryDiProvider),
    );

    final getStudentDto = getStudentUseCase.execute();
    return getStudentDto;
  }
}
