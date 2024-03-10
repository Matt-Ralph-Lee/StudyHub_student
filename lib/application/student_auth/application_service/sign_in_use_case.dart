import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';

class SignInUseCase {
  final IStudentAuthRepository _repository;

  SignInUseCase({
    required final IStudentAuthRepository repository,
  }) : _repository = repository;

  Future<void> execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    await _repository.signIn(emailAddress: emailAddress, password: password);
  }
}
