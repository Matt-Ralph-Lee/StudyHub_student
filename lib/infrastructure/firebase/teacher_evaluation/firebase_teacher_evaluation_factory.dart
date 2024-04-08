import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_factory.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import 'firebase_teacher_evaluation_repository.dart';

class FirebaseTeacherEvaluationFactory implements ITeacherEvaluationFactory {
  final FirebaseTeacherEvaluationRepository _repository;

  FirebaseTeacherEvaluationFactory(this._repository);

  @override
  Future<TeacherEvaluation> createTeacherEvaluation({
    required StudentId from,
    required TeacherId to,
    required TeacherEvaluationRating rating,
    required TeacherEvaluationComment comment,
    required DateTime createdAt,
  }) async {
    final id = await _repository.generateId();

    return TeacherEvaluation(
      id: id,
      from: from,
      to: to,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }
}
