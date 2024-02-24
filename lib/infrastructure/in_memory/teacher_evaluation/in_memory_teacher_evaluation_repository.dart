import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class InMemoryTeacherEvaluationRepository
    implements ITeacherEvaluationRepository {
  final store = <TeacherId, List<TeacherEvaluation>>{};
  @override
  Future<void> save(TeacherEvaluation evaluation) async {
    final teacherId = evaluation.to;
    if (store[teacherId] == null) {
      store[teacherId] = [evaluation];
    } else {
      store[teacherId]!.add(evaluation);
    }
  }

// fetch all evaluation from store and convert to evaluation
  @override
  List<TeacherEvaluation>? getByTeacherId(TeacherId teacherId) {
    final evaluation = store[teacherId];
    if (evaluation == null) return null;
    return evaluation;
  }
}
