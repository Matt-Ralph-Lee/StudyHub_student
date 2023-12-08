import 'package:studyhub/domain/student_auth/models/i_student_auth_repository.dart';

import '../../domain/student_auth/models/email_address.dart';

class ResetPasswordService {
  final IStudentAuthRepository _repository;
  ResetPasswordService({required final IStudentAuthRepository repository})
      : _repository = repository;

  void execute(final String emailAddressData) {
    final emailAddress = EmailAddress(emailAddressData);
    _repository.resetPassword(emailAddress);
  }
}
