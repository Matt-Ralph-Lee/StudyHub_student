import 'package:uuid/uuid.dart';

import '../../photo/models/photo.dart';
import 'email_address.dart';
import 'gender.dart';
import 'grade.dart';
import 'occupation.dart';
import '../../account/password.dart';
import 'school_name.dart';
import 'student_id.dart';
import 'student_name.dart';

class Student {
  final StudentId _studentId;
  final Password _password;
  bool _isAuthenticated;
  EmailAddress _emailAddress;
  StudentName _studentName;
  Photo? _profilePhoto;
  Gender _gender;
  Occupation _occupation;
  SchoolName _schoolName;
  Grade _grade;

  EmailAddress get emailAddress => _emailAddress;
  bool get isAuthenticated => _isAuthenticated;

  Student({
    required final StudentId studentId,
    required final Password password,
    required final bool isauthenticated,
    required final EmailAddress emailAddress,
    required final StudentName studentName,
    required final Photo? profilePhoto,
    required final Gender gender,
    required final Occupation occupation,
    required final SchoolName schoolName,
    required final Grade grade,
  })  : _studentId = studentId,
        _password = password,
        _isAuthenticated = isauthenticated,
        _emailAddress = emailAddress,
        _studentName = studentName,
        _profilePhoto = profilePhoto,
        _gender = gender,
        _occupation = occupation,
        _schoolName = schoolName,
        _grade = grade;

  void changeEmailAddress(final EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }
}
