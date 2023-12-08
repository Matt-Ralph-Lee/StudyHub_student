import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';

class ResetPasswordService {
  final IStudentAuthRepository _repository;
  ResetPasswordService({required final IStudentAuthRepository repository})
      : _repository = repository;

  void execute(final String emailAddressData) {
    final emailAddress = EmailAddress(emailAddressData);
    _repository.resetPassword(emailAddress);
  }
}
