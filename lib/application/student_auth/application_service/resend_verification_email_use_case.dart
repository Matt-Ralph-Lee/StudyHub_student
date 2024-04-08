import '../../../domain/student_auth/models/i_student_auth_repository.dart';

class ResendVerificationEmailUseCase {
  final IStudentAuthRepository _repository;

  ResendVerificationEmailUseCase(this._repository);

  Future<void> execute(final String emailAddressData) async {
    await _repository.sendEmailVerification();
  }
}
