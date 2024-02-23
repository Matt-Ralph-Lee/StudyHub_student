import 'teacher_evaluation_comment.dart';
import 'teacher_evaluation_rating.dart';
import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';

class TeacherEvaluation {
  final StudentId _from;
  final TeacherId _to;
  final TeacherEvaluationRating _rating;
  final TeacherEvaluationComment _comment;

  StudentId get from => _from;
  TeacherId get to => _to;
  TeacherEvaluationRating get rating => _rating;
  TeacherEvaluationComment get comment => _comment;

  TeacherEvaluation({
    required StudentId from,
    required TeacherId to,
    required TeacherEvaluationRating rating,
    required TeacherEvaluationComment comment,
  })  : _from = from,
        _to = to,
        _rating = rating,
        _comment = comment;
}
