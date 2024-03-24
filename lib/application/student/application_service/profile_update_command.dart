import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade_or_graduate_status.dart';
import '../../../domain/student/models/occupation.dart';

class ProfileUpdateCommand {
  final String? _studentName;
  final Gender? _gender;
  final Occupation? _occupation;
  final String? _school;
  final GradeOrGraduateStatus? _gradeOrGraduateStatus;
  final String? _localPhotoPath;

  String? get studentName => _studentName;
  Gender? get gender => _gender;
  Occupation? get occupation => _occupation;
  String? get school => _school;
  GradeOrGraduateStatus? get gradeOrGraduateStatus => _gradeOrGraduateStatus;
  String? get localPhotoPath => _localPhotoPath;

  ProfileUpdateCommand({
    required final String? studentName,
    required final Gender? gender,
    required final Occupation? occupation,
    required final String? school,
    required final GradeOrGraduateStatus? gradeOrGraduateStatus,
    required final String? localPhotoPath,
  })  : _studentName = studentName,
        _gender = gender,
        _occupation = occupation,
        _school = school,
        _gradeOrGraduateStatus = gradeOrGraduateStatus,
        _localPhotoPath = localPhotoPath;
}
