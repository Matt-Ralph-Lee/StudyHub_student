import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/student/student_provider.dart";
import "../../../application/di/student_auth/student_auth_provider.dart";
import "../../../application/student/application_service/student_create_use_case.dart";
import "../../../application/student_auth/application_service/sign_in_use_case.dart";
import "../../../application/student_auth/application_service/sign_out_use_case.dart";

part "student_auth_controller.g.dart";

@riverpod
class StudentAuthController extends _$StudentAuthController {
  @override
  Future<void> build() async {}

  Future<void> signUp(String emailAddress, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final studentRepository = ref.read(studentRepositoryDiProvider);
      final signUpUseCase = StudentCreateUseCase(
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
      );
      await signUpUseCase.execute(
          emailAddressData: emailAddress, passwordData: password);
    });
  }

  Future<void> login(String emailAddress, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final signInUseCase = SignInUseCase(repository: studentAuthRepository);
      await signInUseCase.execute(
          emailAddressData: emailAddress, passwordData: password);
    });
  }

  Future<void> singOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final signInUseCase = SignOutUseCase(repository: studentAuthRepository);
      await signInUseCase.execute();
    });
  }
}
