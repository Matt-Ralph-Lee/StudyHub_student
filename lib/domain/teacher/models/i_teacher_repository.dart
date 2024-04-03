import '../../teacher_evaluation/models/teacher_evaluation.dart';
import 'teacher.dart';
import 'teacher_id.dart';

abstract class ITeacherRepository {
  Teacher? getByTeacherId(final TeacherId teacherId);
  void changeRate(final TeacherEvaluation evaluation);
}
