import '../models/student_auth_info.dart';
import '../models/i_student_auth_repository.dart';

class StudentAuthDomainService {
  final IStudentAuthRepository _repository;

  StudentAuthDomainService(final IStudentAuthRepository repository)
      : _repository = repository;

  bool exists(final StudentAuthInfo studentAuthInfo) {
    final found = _repository.findByEmailAddress(studentAuthInfo.emailAddress);
    return found != null;
  }

  void requireVerification(final StudentAuthInfo account) {
    _repository.verifyWithEmail(account.studentId);
  }
}
