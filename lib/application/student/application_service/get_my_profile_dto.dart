import '../../../domain/student/models/status.dart';

class GetMyProfileDto {
  final String _studentName;
  final String _profilePhotoPath;
  final Status _status;
  final int _questionCount;

  String get studentName => _studentName;
  String get profilePhotoPath => _profilePhotoPath;
  Status get status => _status;
  int get questionCount => _questionCount;

  GetMyProfileDto(
      {required String studentName,
      required String profilePhotoPath,
      required Status status,
      required int questionCount})
      : _studentName = studentName,
        _profilePhotoPath = profilePhotoPath,
        _status = status,
        _questionCount = questionCount;
}
