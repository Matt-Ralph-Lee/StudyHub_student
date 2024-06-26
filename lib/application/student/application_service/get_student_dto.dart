import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/occupation.dart';
import '../../../domain/student/models/status.dart';
import '../../../domain/student/models/student.dart';

class GetStudentDto {
  final String _studentName;
  final Gender _gender;
  final GradeOrGraduateStatus _gradeOrGraduateStatus;
  final Occupation _occupation;
  final String _profilePhotoPath;
  final int _questionCount;
  final String _school;
  final Status _status;

  String get studentName => _studentName;
  Gender get gender => _gender;
  GradeOrGraduateStatus get gradeOrGraduateStatus => _gradeOrGraduateStatus;
  Occupation get occupation => _occupation;
  String get profilePhotoPath => _profilePhotoPath;
  int get questionCount => _questionCount;
  String get school => _school;
  Status get status => _status;

  GetStudentDto._(
      {required final String studentName,
      required final Gender gender,
      required final GradeOrGraduateStatus gradeOrGraduateStatus,
      required final Occupation occupation,
      required final String profilePhotoPath,
      required final int questionCount,
      required final String school,
      required final Status status})
      : _studentName = studentName,
        _gender = gender,
        _gradeOrGraduateStatus = gradeOrGraduateStatus,
        _occupation = occupation,
        _profilePhotoPath = profilePhotoPath,
        _questionCount = questionCount,
        _school = school,
        _status = status;

  factory GetStudentDto.fromDomainObject(final Student student) {
    return GetStudentDto._(
      studentName: student.name.value,
      gender: student.gender,
      gradeOrGraduateStatus: student.gradeOrGraduateStatus,
      occupation: student.occupation,
      profilePhotoPath: student.profilePhotoPath.value,
      questionCount: student.questionCount.value,
      school: student.school.value,
      status: student.status,
    );
  }
}
