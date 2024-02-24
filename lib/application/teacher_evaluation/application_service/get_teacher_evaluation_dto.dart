import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class GetTeacherEvaluationDto {
  final StudentId _from;
  final TeacherId _to;
  final int _rating;
  final String _comment;

  StudentId get from => _from;
  TeacherId get to => _to;
  int get rating => _rating;
  String get comment => _comment;

  GetTeacherEvaluationDto({
    required final StudentId from,
    required final TeacherId to,
    required final int rating,
    required final String comment,
  })  : _from = from,
        _to = to,
        _rating = rating,
        _comment = comment;
}
