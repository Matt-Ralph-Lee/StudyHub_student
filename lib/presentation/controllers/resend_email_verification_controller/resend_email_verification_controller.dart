import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/student_auth/student_auth_provider.dart";
import "../../../application/student_auth/application_service/resend_verification_email_use_case.dart";

part "resend_email_verification_controller.g.dart";

@riverpod
class ResendEmailVerificationController
    extends _$ResendEmailVerificationController {
  @override
  Future<void> build() async {}

  Future<void> resendEmailVerification(String emailAddress) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final signUpUseCase =
          ResendVerificationEmailUseCase(studentAuthRepository);
      await signUpUseCase.execute(emailAddress);
    });
  }
}
