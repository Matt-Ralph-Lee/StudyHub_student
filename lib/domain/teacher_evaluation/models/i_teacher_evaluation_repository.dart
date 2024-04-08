import '../../teacher/models/teacher_id.dart';
import 'teacher_evaluation.dart';
import 'teacher_evaluation_id.dart';

abstract class ITeacherEvaluationRepository {
  Future<void> save(final TeacherEvaluation evaluation);
  Future<List<TeacherEvaluation>?> getByTeacherId(final TeacherId teacherId);
  Future<TeacherEvaluationId> generateId(final TeacherId teacherId);
}
