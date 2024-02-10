import 'evaluation_comment.dart';
import 'evaluation_rating.dart';
import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';

class Evaluation {
  final StudentId _from;
  final TeacherId _to;
  final EvaluationRating _rating;
  final EvaluationComment _comment;

  StudentId get from => _from;
  TeacherId get to => _to;
  EvaluationRating get rating => _rating;
  EvaluationComment get comment => _comment;

  Evaluation({
    required StudentId from,
    required TeacherId to,
    required EvaluationRating rating,
    required EvaluationComment comment,
  })  : _from = from,
        _to = to,
        _rating = rating,
        _comment = comment;
}
