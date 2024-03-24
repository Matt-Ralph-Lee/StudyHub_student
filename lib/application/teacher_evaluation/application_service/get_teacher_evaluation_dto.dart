import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class GetTeacherEvaluationDto {
  final StudentId _from;
  final TeacherId _to;
  final int _rating;
  final String _comment;
  final DateTime _createdAt;

  StudentId get from => _from;
  TeacherId get to => _to;
  int get rating => _rating;
  String get comment => _comment;
  DateTime get createdAt => _createdAt;

  GetTeacherEvaluationDto({
    required final StudentId from,
    required final TeacherId to,
    required final int rating,
    required final String comment,
    required final DateTime createdAt,
  })  : _from = from,
        _to = to,
        _rating = rating,
        _comment = comment,
        _createdAt = createdAt;
}
