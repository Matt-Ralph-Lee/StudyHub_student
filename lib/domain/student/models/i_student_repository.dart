import 'student_id.dart';
import '../../student_auth/models/email_address.dart';
import 'student.dart';

abstract class IStudentRepository {
  void save(final Student student);
  void delete(final StudentId studentId);
  Student? findByEmailAddress(final EmailAddress emailAddress);
  Student? findById(final StudentId studentId);
}
