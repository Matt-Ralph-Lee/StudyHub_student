import 'profile_photo_path.dart';
import 'question_count.dart';
import 'status.dart';
import 'student_id.dart';
import 'gender.dart';
import 'grade.dart';
import 'occupation.dart';
import 'school_name.dart';
import 'student_name.dart';

class Student {
  final StudentId _studentId;
  StudentName _studentName;
  ProfilePhotoPath _profilePhotoPath;
  Gender _gender;
  Occupation _occupation;
  SchoolName _schoolName;
  Grade _grade;
  QuestionCount _questionCount;
  Status _status;

  StudentId get studentId => _studentId;
  StudentName get studentName => _studentName;
  ProfilePhotoPath get profilePhotoPath => _profilePhotoPath;
  Gender get gender => _gender;
  Occupation get occupation => _occupation;
  SchoolName get schoolName => _schoolName;
  Grade get grade => _grade;
  QuestionCount get questionCount => _questionCount;
  Status get status => _status;

  Student({
    required final StudentId studentId,
    required final StudentName studentName,
    required final ProfilePhotoPath profilePhotoPath,
    required final Gender gender,
    required final Occupation occupation,
    required final SchoolName schoolName,
    required final Grade grade,
    required final QuestionCount questionCount,
    required final Status status,
  })  : _studentId = studentId,
        _studentName = studentName,
        _profilePhotoPath = profilePhotoPath,
        _gender = gender,
        _occupation = occupation,
        _schoolName = schoolName,
        _grade = grade,
        _questionCount = questionCount,
        _status = status;

  void changeProfilePhoto(final ProfilePhotoPath newProfilePhotoPath) {
    _profilePhotoPath = newProfilePhotoPath;
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

  void incrementQuestionCount() {
    final currentCount = _questionCount.value;
    final newCount = currentCount + 1;
    _questionCount = QuestionCount(newCount);
    setStatus();
  }

  void setStatus() {
    if (questionCount > Status.expert.minQuestionCount) {
      _status = Status.expert;
    } else if (questionCount > Status.advanced.minQuestionCount) {
      _status = Status.advanced;
    } else if (questionCount > Status.novice.minQuestionCount) {
      _status = Status.novice;
    } else {
      _status = Status.beginner;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Student) {
      return runtimeType == other.runtimeType && studentId == other.studentId;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => studentId.hashCode;
}
