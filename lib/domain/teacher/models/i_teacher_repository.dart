import 'teacher.dart';
import 'teacher_id.dart';

abstract class ITeacherRepository {
  Teacher? getByTeacherId(final TeacherId teacherId);
}
