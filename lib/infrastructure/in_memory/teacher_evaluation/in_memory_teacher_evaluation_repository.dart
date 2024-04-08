import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_id.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import '../student/in_memory_student_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';

class InMemoryTeacherEvaluationRepository
    implements ITeacherEvaluationRepository {
  late Map<TeacherId, List<TeacherEvaluation>> store;
  late int _idInt;
  static final InMemoryTeacherEvaluationRepository _instance =
      InMemoryTeacherEvaluationRepository._internal();

  factory InMemoryTeacherEvaluationRepository() {
    return _instance;
  }

  InMemoryTeacherEvaluationRepository._internal() {
    store = {};
    _idInt = 1000000;
  }

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
  Future<List<TeacherEvaluation>?> getByTeacherId(TeacherId teacherId) async {
    final evaluation = store[teacherId];
    if (evaluation == null) return null;
    return evaluation;
  }

  @override
  Future<TeacherEvaluationId> generateId(TeacherId teacherId) async {
    const idStr = "thisIsATestId";

    String randomId = _idInt.toString() + idStr;

    _idInt++;

    return TeacherEvaluationId(randomId);
  }
}

class InMemoryTeacherEvaluationIdInitialValue {
  static final teacherEvaluationId1FromS1toT1 =
      TeacherEvaluationId('00000000000000000001');
  static final teacherEvaluationId2FromS1toT2 =
      TeacherEvaluationId('00000000000000000002');
  static final teacherEvaluationId3FromS2toT2 =
      TeacherEvaluationId("00000000000000000003");
  static final teacherEvaluationId4FromS1toT3 =
      TeacherEvaluationId("00000000000000000004");
  static final teacherEvaluationId5FromS2toT3 =
      TeacherEvaluationId("00000000000000000005");
}

class InMemoryTeacherEvaluationInitialValue {
  static final teacherEvaluation1FromS1toT1 = TeacherEvaluation(
    id: InMemoryTeacherEvaluationIdInitialValue.teacherEvaluationId1FromS1toT1,
    from: InMemoryStudentInitialValue.student1.studentId,
    to: InMemoryTeacherInitialValue.teacher1.teacherId,
    rating: TeacherEvaluationRating(4),
    comment: TeacherEvaluationComment("言い教え方を知っている"),
    createdAt: DateTime.now(),
  );
  static final teacherEvaluation2FromS1toT2 = TeacherEvaluation(
    id: InMemoryTeacherEvaluationIdInitialValue.teacherEvaluationId2FromS1toT2,
    from: InMemoryStudentInitialValue.student1.studentId,
    to: InMemoryTeacherInitialValue.teacher2.teacherId,
    rating: TeacherEvaluationRating(5),
    comment: TeacherEvaluationComment("まぁまぁいい感じな先生だ"),
    createdAt: DateTime.now(),
  );
  static final teacherEvaluation3FromS2toT2 = TeacherEvaluation(
    id: InMemoryTeacherEvaluationIdInitialValue.teacherEvaluationId3FromS2toT2,
    from: InMemoryStudentInitialValue.student2.studentId,
    to: InMemoryTeacherInitialValue.teacher2.teacherId,
    rating: TeacherEvaluationRating(2),
    comment: TeacherEvaluationComment("なかなかいい感じな先生だ"),
    createdAt: DateTime.now(),
  );
  static final teacherEvaluation4FromS1toT3 = TeacherEvaluation(
    id: InMemoryTeacherEvaluationIdInitialValue.teacherEvaluationId4FromS1toT3,
    from: InMemoryStudentInitialValue.student1.studentId,
    to: InMemoryTeacherInitialValue.teacher3.teacherId,
    rating: TeacherEvaluationRating(5),
    comment: TeacherEvaluationComment("厳密でよい先生だ"),
    createdAt: DateTime.now(),
  );
  static final teacherEvaluation5FromS2toT3 = TeacherEvaluation(
    id: InMemoryTeacherEvaluationIdInitialValue.teacherEvaluationId5FromS2toT3,
    from: InMemoryStudentInitialValue.student2.studentId,
    to: InMemoryTeacherInitialValue.teacher3.teacherId,
    rating: TeacherEvaluationRating(2),
    comment: TeacherEvaluationComment("きびしすぎるよぉーーー"),
    createdAt: DateTime.now(),
  );
}
