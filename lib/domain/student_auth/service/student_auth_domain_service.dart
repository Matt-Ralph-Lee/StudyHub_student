import '../models/student_auth_info.dart';
import '../models/i_student_auth_repository.dart';

class StudentAuthDomainService {
  final IStudentAuthRepository _repository;

  StudentAuthDomainService(final IStudentAuthRepository repository)
      : _repository = repository;

  bool exists(final StudentAuthInfo account) {
    final found = _repository.findByEmailAddress(account.emailAddress);
    return found != null;
  }

  void requireVerification(final StudentAuthInfo account) {
    _repository.verify(account.emailAddress);
  }
}
