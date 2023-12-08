import 'student_id.dart';
import '../../photo/models/photo.dart';
import 'gender.dart';
import 'grade.dart';
import 'occupation.dart';
import 'school_name.dart';
import 'student_name.dart';

class Student {
  final StudentId _accountId;
  StudentName _studentName;
  Photo _profilePhoto;
  Gender _gender;
  Occupation _occupation;
  SchoolName _schoolName;
  Grade _grade;

  StudentId get accountId => _accountId;
  StudentName get studentName => _studentName;
  Photo get profilePhoto => _profilePhoto;
  Gender get gender => _gender;
  Occupation get occupation => _occupation;
  SchoolName get schoolName => _schoolName;
  Grade get grade => _grade;

  Student({
    required final StudentId accountId,
    required final StudentName studentName,
    required final Photo profilePhoto,
    required final Gender gender,
    required final Occupation occupation,
    required final SchoolName schoolName,
    required final Grade grade,
  })  : _accountId = accountId,
        _studentName = studentName,
        _profilePhoto = profilePhoto,
        _gender = gender,
        _occupation = occupation,
        _schoolName = schoolName,
        _grade = grade;
}
