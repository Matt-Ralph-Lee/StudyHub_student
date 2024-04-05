import '../../teacher_evaluation/models/teacher_evaluation.dart';
import 'teacher.dart';
import 'teacher_id.dart';

abstract class ITeacherRepository {
  Future<Teacher?> getByTeacherId(final TeacherId teacherId);
  Future<void> changeRate(final TeacherEvaluation evaluation);
}
