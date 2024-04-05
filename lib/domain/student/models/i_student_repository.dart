import 'student_id.dart';
import 'student.dart';

abstract class IStudentRepository {
  Future<void> save(final Student student);
  Future<void> delete(final StudentId studentId);
  Future<Student?> findById(final StudentId studentId);
}
