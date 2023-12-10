import 'student_id.dart';
import 'student.dart';

abstract class IStudentFactory {
  Student createInitially(final StudentId studentId);
}
