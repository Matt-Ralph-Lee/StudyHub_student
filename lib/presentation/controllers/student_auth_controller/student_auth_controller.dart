import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/student/student_provider.dart";
import "../../../application/di/student_auth/student_auth_provider.dart";
import '../../../application/student/application_service/reload_user_use_case.dart';
import "../../../application/student/application_service/student_create_use_case.dart";
import "../../../application/student_auth/application_service/sign_in_use_case.dart";
import "../../../application/student_auth/application_service/sign_out_use_case.dart";
import "../../../application/student_auth/application_service/update_student_auth_info_command.dart";
import "../../../application/student_auth/application_service/update_student_auth_info_use_case.dart";
import "../../../domain/student/service/student_service.dart";

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
      final logger = ref.read(loggerDiProvider);
      final signUpUseCase = StudentCreateUseCase(
        studentAuthRepository: studentAuthRepository,
        studentRepository: studentRepository,
        logger: logger,
      );
      await signUpUseCase.execute(
          emailAddressData: emailAddress, passwordData: password);
    });
  }

  Future<void> login(String emailAddress, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final studentRepository = ref.read(studentRepositoryDiProvider);
      final service = StudentService(studentRepository);
      final logger = ref.read(loggerDiProvider);
      final signInUseCase = SignInUseCase(
        repository: studentAuthRepository,
        service: service,
        logger: logger,
      );
      await signInUseCase.execute(
          emailAddressData: emailAddress, passwordData: password);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final signInUseCase = SignOutUseCase(
        repository: studentAuthRepository,
        logger: logger,
      );
      await signInUseCase.execute();
    });
  }

  Future<void> resetPassword(final String emailAddress) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final studentRepository = ref.read(studentRepositoryDiProvider);
      final command = UpdateStudentAuthInfoCommand(
          emailAddress: null, emailAddressToResetPassword: emailAddress);
      final logger = ref.read(loggerDiProvider);
      final usecase = UpdateStudentAuthInfoUseCase(
        repository: studentAuthRepository,
        studentRepository: studentRepository,
        logger: logger,
      );

      await usecase.execute(command);
    });
  }

  Future<void> reloadUser() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final reloadUser = ReloadUserUseCase(
        repository: studentAuthRepository,
        logger: logger,
      );

      await reloadUser.execute();
    });
  }
}
