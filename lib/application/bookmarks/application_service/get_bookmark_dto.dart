import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/student/models/student_id.dart';

class GetBookmarkDto {
  final String _studentProfilePhoto;
  final String _questionTitle;
  final String _questionText;
  final TeacherId? _teacherId;
  final String? _teacherProfilePhoto;
  final String? _answerText;

  String get studentProfilePhoto => _studentProfilePhoto;
  String get questionTitle => _questionTitle;
  String get qeustionText => _questionText;
  TeacherId? get teacherId => _teacherId;
  String? get teacherProfilePhoto => _teacherProfilePhoto;
  String? get answerText => _answerText;

  GetBookmarkDto({
    required final StudentId studentId,
    required final String studentProfilePhoto,
    required final String questionTitle,
    required final String questionText,
    required final TeacherId? teacherId,
    required final String? teacherProfilePhoto,
    required final String? answerText,
  })  : _studentProfilePhoto = studentProfilePhoto,
        _questionTitle = questionTitle,
        _questionText = questionText,
        _teacherId = teacherId,
        _teacherProfilePhoto = teacherProfilePhoto,
        _answerText = answerText;
}
