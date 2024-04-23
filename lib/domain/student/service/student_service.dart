import '../../student_auth/models/email_address.dart';
import '../models/i_student_repository.dart';

class StudentService {
  final IStudentRepository _repository;

  StudentService(this._repository);

  Future<bool> isStudent(final EmailAddress emailAddress) async {
    return await _repository.isStudent(emailAddress);
  }
}
