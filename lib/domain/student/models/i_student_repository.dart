import 'student_id.dart';
import 'student.dart';

abstract class IStudentRepository {
  void save(final Student student);
  void delete(final StudentId studentId);
  Student? findById(final StudentId studentId);
}
