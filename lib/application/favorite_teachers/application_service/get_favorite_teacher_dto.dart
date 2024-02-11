class GetFavoriteTeacherDto {
  final String _teacherName;
  final String _profilePhotoPath;
  final String _bio;

  String get teacherName => _teacherName;
  String get profilePhotoPath => _profilePhotoPath;
  String get bio => _bio;

  GetFavoriteTeacherDto({
    required String teacherName,
    required String profilePhotoPath,
    required String bio,
  })  : _teacherName = teacherName,
        _profilePhotoPath = profilePhotoPath,
        _bio = bio;
}
