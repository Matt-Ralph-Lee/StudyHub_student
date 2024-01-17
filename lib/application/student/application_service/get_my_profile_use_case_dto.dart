import '../../../domain/student/models/profile_photo_path.dart';
import '../../../domain/student/models/question_count.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student_name.dart';

class GetMyProfileUseCaseDto {
  final String _studentName;
  final String _profilePhotoPath;
  final Status _status;
  final int _questionCount;

  String get studentName => _studentName;
  String get profilePhotoPath => _profilePhotoPath;
  Status get status => _status;
  int get questionCount => _questionCount;

  GetMyProfileUseCaseDto._(
      {required String studentName,
      required String profilePhotoPath,
      required Status status,
      required int questionCount})
      : _studentName = studentName,
        _profilePhotoPath = profilePhotoPath,
        _status = status,
        _questionCount = questionCount;

  factory GetMyProfileUseCaseDto.fromDomainObject({
    required final StudentName studentName,
    required final ProfilePhotoPath profilePhotoPath,
    required final Status status,
    required final QuestionCount questionCount,
  }) {
    final studentNameData = studentName.value;
    final profilePhotoPathData = profilePhotoPath.value;
    final questionCountData = questionCount.value;
    return GetMyProfileUseCaseDto._(
      studentName: studentNameData,
      profilePhotoPath: profilePhotoPathData,
      status: status,
      questionCount: questionCountData,
    );
  }
}
