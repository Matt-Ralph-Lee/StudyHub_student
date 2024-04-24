import '../../student_auth/models/email_address.dart';
import 'student_id.dart';
import 'student.dart';

abstract class IStudentRepository {
  Future<void> create(final Student student);
  Future<void> update(final Student student);
  Future<void> delete(final StudentId studentId);
  Future<Student?> findById(final StudentId studentId);
  Future<void> incrementQuestionCount(final StudentId studentId);
  Future<bool> isStudent(final EmailAddress emailAddress);
  Future<void> updateEmailAddress({
    required final StudentId studentId,
    required final EmailAddress newEmailAddress,
  });
}
