import '../../teacher/models/teacher_id.dart';
import 'teacher_evaluation.dart';

abstract class ITeacherEvaluationRepository {
  Future<void> save(final TeacherEvaluation evaluation);
  List<TeacherEvaluation>? getByTeacherId(final TeacherId teacherId);
}
