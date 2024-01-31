import '../../school/models/school.dart';
import '../../shared/profile_photo_path.dart';
import 'question_count.dart';
import 'status.dart';
import 'student_id.dart';
import 'gender.dart';
import 'grade.dart';
import 'occupation.dart';
import '../../shared/name.dart';

class Student {
  final StudentId _studentId;
  Name _studentName;
  ProfilePhotoPath _profilePhotoPath;
  Gender _gender;
  Occupation _occupation;
  School _school;
  Grade _grade;
  QuestionCount _questionCount;
  Status _status;

  StudentId get studentId => _studentId;
  Name get studentName => _studentName;
  ProfilePhotoPath get profilePhotoPath => _profilePhotoPath;
  Gender get gender => _gender;
  Occupation get occupation => _occupation;
  School get school => _school;
  Grade get grade => _grade;
  QuestionCount get questionCount => _questionCount;
  Status get status => _status;

  Student({
    required final StudentId studentId,
    required final Name studentName,
    required final ProfilePhotoPath profilePhotoPath,
    required final Gender gender,
    required final Occupation occupation,
    required final School school,
    required final Grade grade,
    required final QuestionCount questionCount,
    required final Status status,
  })  : _studentId = studentId,
        _studentName = studentName,
        _profilePhotoPath = profilePhotoPath,
        _gender = gender,
        _occupation = occupation,
        _school = school,
        _grade = grade,
        _questionCount = questionCount,
        _status = status {
    setStatus();
  }

  void changeProfilePhoto(final ProfilePhotoPath newProfilePhotoPath) {
    _profilePhotoPath = newProfilePhotoPath;
  }

  void changeStudentName(final Name newStudentName) {
    _studentName = newStudentName;
  }

  void changeGender(final Gender newGender) {
    _gender = newGender;
  }

  void changeOccupation(final Occupation newOccupation) {
    _occupation = newOccupation;
  }

  void changeSchool(final School newSchool) {
    _school = newSchool;
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
    if (questionCount >= Status.expert.minQuestionCount) {
      _status = Status.expert;
    } else if (questionCount >= Status.advanced.minQuestionCount) {
      _status = Status.advanced;
    } else if (questionCount >= Status.novice.minQuestionCount) {
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
