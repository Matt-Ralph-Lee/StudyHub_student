import '../../../domain/teacher/models/teacher_id.dart';

class SearchForTeacherDto {
  final TeacherId _teacherId;
  final String _name;
  final String _profilePhotoPath;
  final String _bio;

  SearchForTeacherDto({
    required final TeacherId teacherId,
    required final String name,
    required final String profilePhotoPath,
    required final String bio,
  })  : _teacherId = teacherId,
        _name = name,
        _profilePhotoPath = profilePhotoPath,
        _bio = bio;

  TeacherId get teacherId => _teacherId;
  String get name => _name;
  String get profilePhotoPath => _profilePhotoPath;
  String get bio => _bio;
}
