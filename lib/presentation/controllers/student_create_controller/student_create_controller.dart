import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_repository_provider.dart";
import "../../../application/di/student_auth/student_auth_provider.dart";
import "../../../application/student/application_service/student_create_use_case.dart";

part "student_create_controller.g.dart";

@riverpod
class StudentCreateController extends _$StudentCreateController {
  @override
  Future<void> build() async {}

  Future<void> createStudent(String emailAddress, String password) async {
    final session = ref.watch(sessionDiProvider);
    final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
    final studentRepository = ref.read(studentRepositoryDiProvider);

    final studentCreateUseCase = StudentCreateUseCase(
      session: session,
      studentAuthRepository: studentAuthRepository,
      studentRepository: studentRepository,
    );

    await studentCreateUseCase.execute(
        emailAddressData: emailAddress, passwordData: password);
  }
}
