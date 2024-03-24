import 'teacher_evaluation_comment.dart';
import 'teacher_evaluation_rating.dart';
import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';

class TeacherEvaluation {
  final StudentId _from;
  final TeacherId _to;
  final TeacherEvaluationRating _rating;
  final TeacherEvaluationComment _comment;
  final DateTime _createdAt;

  StudentId get from => _from;
  TeacherId get to => _to;
  TeacherEvaluationRating get rating => _rating;
  TeacherEvaluationComment get comment => _comment;
  DateTime get createdAt => _createdAt;

  TeacherEvaluation({
    required final StudentId from,
    required final TeacherId to,
    required final TeacherEvaluationRating rating,
    required final TeacherEvaluationComment comment,
    required final DateTime createdAt,
  })  : _from = from,
        _to = to,
        _rating = rating,
        _comment = comment,
        _createdAt = createdAt;
}
