import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';

class SignInService {
  final IStudentAuthRepository _repository;

  SignInService({
    required final IStudentAuthRepository repository,
  }) : _repository = repository;

  void execute({
    required final String emailAddressData,
    required final String passwordData,
  }) {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    _repository.signIn(emailAddress: emailAddress, password: password);
  }
}
