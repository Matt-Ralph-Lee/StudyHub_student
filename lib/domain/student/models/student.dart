import 'profile_image/profile_image_path.dart';
import 'student_id.dart';
import 'gender.dart';
import 'grade.dart';
import 'occupation.dart';
import 'school_name.dart';
import 'student_name.dart';

class Student {
  final StudentId _studentId;
  StudentName _studentName;
  ProfileImagePath _profileImagePath;
  Gender _gender;
  Occupation _occupation;
  SchoolName _schoolName;
  Grade _grade;

  StudentId get studentId => _studentId;
  StudentName get studentName => _studentName;
  ProfileImagePath get profileImagePath => _profileImagePath;
  Gender get gender => _gender;
  Occupation get occupation => _occupation;
  SchoolName get schoolName => _schoolName;
  Grade get grade => _grade;

  Student({
    required final StudentId studentId,
    required final StudentName studentName,
    required final ProfileImagePath profileImagePath,
    required final Gender gender,
    required final Occupation occupation,
    required final SchoolName schoolName,
    required final Grade grade,
  })  : _studentId = studentId,
        _studentName = studentName,
        _profileImagePath = profileImagePath,
        _gender = gender,
        _occupation = occupation,
        _schoolName = schoolName,
        _grade = grade;

  void changeProfileImage(final ProfileImagePath newProfileImagePath) {
    _profileImagePath = newProfileImagePath;
  }

  void changeStudentName(final StudentName newStudentName) {
    _studentName = newStudentName;
  }

  void changeGender(final Gender newGender) {
    _gender = newGender;
  }

  void changeOccupation(final Occupation newOccupation) {
    _occupation = newOccupation;
  }

  void changeSchoolName(final SchoolName newSchoolName) {
    _schoolName = newSchoolName;
  }

  void changeGrade(final Grade newGrade) {
    _grade = newGrade;
  }
}
