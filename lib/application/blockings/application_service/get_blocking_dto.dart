import '../../../domain/teacher/models/teacher_id.dart';

class GetBlockingDto {
  final TeacherId _teacherId;
  final String _teacherName;

  TeacherId get teacherId => _teacherId;
  String get teacherName => _teacherName;

  GetBlockingDto({
    required final TeacherId teacherId,
    required final String teacherName,
  })  : _teacherId = teacherId,
        _teacherName = teacherName;
}
