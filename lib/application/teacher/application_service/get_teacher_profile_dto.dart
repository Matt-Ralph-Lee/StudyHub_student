class GetTeacherProfileDto {
  final String _name;
  final String _profilePhotoPath;
  final String _highSchool;
  final String _university;
  final String _enrollmentStatus;
  final List<String> _bestSubjects;
  final String _bio;
  final String _introduction;
  final bool _isFollowing;

  GetTeacherProfileDto({
    required final String name,
    required final String profilePhotoPath,
    required final String highSchool,
    required final String university,
    required final String enrollmentStatus,
    required final List<String> bestSubjects,
    required final String bio,
    required final String introduction,
    required final bool isFollowing,
  })  : _name = name,
        _profilePhotoPath = profilePhotoPath,
        _highSchool = highSchool,
        _university = university,
        _enrollmentStatus = enrollmentStatus,
        _bestSubjects = bestSubjects,
        _bio = bio,
        _introduction = introduction,
        _isFollowing = isFollowing;

  String get name => _name;
  String get profilePhotoPath => _profilePhotoPath;
  String get highSchool => _highSchool;
  String get university => _university;
  String get enrollmentStatus => _enrollmentStatus;
  List<String> get bestSubjects => _bestSubjects;
  String get bio => _bio;
  String get introduction => _introduction;
  bool get isFollowing => _isFollowing;
}
