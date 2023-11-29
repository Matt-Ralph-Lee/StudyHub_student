import '../models/email_address.dart';
import '../models/i_student_repository.dart';
import '../models/student.dart';

class StudentDomainService {
  final IAccountRepository _repository;

  StudentDomainService({required final IAccountRepository repository})
      : _repository = repository;

  bool exists(final Student student) {
    final found = _repository.findByEmailAddress(student.emailAddress);
    return found != null;
  }

  void authenticate(final Student student) {
    student.isAuthenticated
  }
}
