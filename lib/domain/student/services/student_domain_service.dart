import '../models/email_address.dart';
import '../models/i_student_repository.dart';

class StudentDomainService {
  final IStudentRepository _repository;

  StudentDomainService({required final IStudentRepository repository})
      : _repository = repository;

  bool exists(final EmailAddress emailAddress) {
    final found = _repository.findByEmailAddress(emailAddress);
    return found != null;
  }
}
