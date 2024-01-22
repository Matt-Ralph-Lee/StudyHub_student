import '../../../domain/student/models/gender.dart';
import '../../../domain/student/models/grade.dart';
import '../../../domain/student/models/occupation.dart';

class ProfileUpdateCommand {
  final String? _studentName;
  final Gender? _gender;
  final Occupation? _occupation;
  final String? _school;
  final Grade? _grade;

  String? get studentName => _studentName;
  Gender? get gender => _gender;
  Occupation? get occupation => _occupation;
  String? get school => _school;
  Grade? get grade => _grade;

  ProfileUpdateCommand({
    required String? studentName,
    required Gender? gender,
    required Occupation? occupation,
    required String? school,
    required Grade? grade,
  })  : _studentName = studentName,
        _gender = gender,
        _occupation = occupation,
        _school = school,
        _grade = grade;
}
