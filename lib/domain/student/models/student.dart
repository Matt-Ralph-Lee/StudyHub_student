import '../../school/models/school.dart';
import '../../shared/profile_photo_path.dart';
import '../exception/student_domain_exception.dart';
import '../exception/student_domain_exception_detail.dart';
import 'grade_or_graduate_status.dart';
import 'question_count.dart';
import 'status.dart';
import 'student_id.dart';
import 'gender.dart';
import 'occupation.dart';
import '../../shared/name.dart';

class Student {
  final StudentId _studentId;
  Name _name;
  ProfilePhotoPath _profilePhotoPath;
  Gender _gender;
  Occupation _occupation;
  School _school;
  GradeOrGraduateStatus _gradeOrGraduateStatus;
  QuestionCount _questionCount;
  Status _status;

  StudentId get studentId => _studentId;
  Name get name => _name;
  ProfilePhotoPath get profilePhotoPath => _profilePhotoPath;
  Gender get gender => _gender;
  Occupation get occupation => _occupation;
  School get school => _school;
  GradeOrGraduateStatus get gradeOrGraduateStatus => _gradeOrGraduateStatus;
  QuestionCount get questionCount => _questionCount;
  Status get status => _status;

  Student({
    required final StudentId studentId,
    required final Name name,
    required final ProfilePhotoPath profilePhotoPath,
    required final Gender gender,
    required final Occupation occupation,
    required final School school,
    required final GradeOrGraduateStatus gradeOrGraduateStatus,
    required final QuestionCount questionCount,
    required final Status status,
  })  : _studentId = studentId,
        _name = name,
        _profilePhotoPath = profilePhotoPath,
        _gender = gender,
        _occupation = occupation,
        _school = school,
        _gradeOrGraduateStatus = gradeOrGraduateStatus,
        _questionCount = questionCount,
        _status = status {
    setStatus();
    if (_occupation == Occupation.student &&
        _gradeOrGraduateStatus == GradeOrGraduateStatus.graduate) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidCombination);
    }
  }

  void changeProfilePhoto(final ProfilePhotoPath newProfilePhotoPath) {
    _profilePhotoPath = newProfilePhotoPath;
  }

  void changeName(final Name newName) {
    _name = newName;
  }

  void changeGender(final Gender newGender) {
    _gender = newGender;
  }

  void changeOccupation(final Occupation newOccupation) {
    if (newOccupation == Occupation.student &&
        _gradeOrGraduateStatus == GradeOrGraduateStatus.graduate) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidCombination);
    }
    _occupation = newOccupation;
  }

  void changeSchool(final School newSchool) {
    _school = newSchool;
  }

  void changeGradeOrGraduateStatus(
      final GradeOrGraduateStatus newGradeOrGraduateStatus) {
    if (_occupation == Occupation.student &&
        newGradeOrGraduateStatus == GradeOrGraduateStatus.graduate) {
      throw const StudentDomainException(
          StudentDomainExceptionDetail.invalidCombination);
    }
    _gradeOrGraduateStatus = newGradeOrGraduateStatus;
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
