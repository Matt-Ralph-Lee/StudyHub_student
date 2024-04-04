import '../../teacher/models/teacher_id.dart';
import 'teacher_evaluation.dart';
import 'teacher_evaluation_id.dart';

abstract class ITeacherEvaluationRepository {
  Future<void> save(final TeacherEvaluation evaluation);
  List<TeacherEvaluation>? getByTeacherId(final TeacherId teacherId);
  TeacherEvaluationId generateId();
}
