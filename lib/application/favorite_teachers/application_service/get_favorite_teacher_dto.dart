import '../../../domain/teacher/models/teacher_id.dart';

class GetFavoriteTeacherDto {
  final TeacherId _teacherId;
  final String _teacherName;
  final String _profilePhotoPath;
  final String _bio;

  TeacherId get teacherId => _teacherId;
  String get teacherName => _teacherName;
  String get profilePhotoPath => _profilePhotoPath;
  String get bio => _bio;

  GetFavoriteTeacherDto({
    required TeacherId teacherId,
    required String teacherName,
    required String profilePhotoPath,
    required String bio,
  })  : _teacherId = teacherId,
        _teacherName = teacherName,
        _profilePhotoPath = profilePhotoPath,
        _bio = bio;
}
