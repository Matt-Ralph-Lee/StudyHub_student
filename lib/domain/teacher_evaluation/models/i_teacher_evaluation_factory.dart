import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';
import 'teacher_evaluation.dart';
import 'teacher_evaluation_comment.dart';
import 'teacher_evaluation_rating.dart';

abstract class ITeacherEvaluationFactory {
  Future<TeacherEvaluation> createTeacherEvaluation({
    required final StudentId from,
    required final TeacherId to,
    required final TeacherEvaluationRating rating,
    required final TeacherEvaluationComment comment,
    required final DateTime createdAt,
  });
}
