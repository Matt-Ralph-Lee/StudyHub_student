import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade.dart';
import '../../../domain/student/models/occupation.dart';

class ProfileUpdateCommand {
  final String? _studentName;
  final Gender? _gender;
  final Occupation? _occupation;
  final String? _school;
  final Grade? _grade;
  final String? _localPhotoPath;

  String? get studentName => _studentName;
  Gender? get gender => _gender;
  Occupation? get occupation => _occupation;
  String? get school => _school;
  Grade? get grade => _grade;
  String? get localPhotoPath => _localPhotoPath;

  ProfileUpdateCommand({
    required final String? studentName,
    required final Gender? gender,
    required final Occupation? occupation,
    required final String? school,
    required final Grade? grade,
    required final String? localPhotoPath,
  })  : _studentName = studentName,
        _gender = gender,
        _occupation = occupation,
        _school = school,
        _grade = grade,
        _localPhotoPath = localPhotoPath;
}
