import 'package:english_words/english_words.dart';
import 'package:uuid/uuid.dart';

import 'email_address.dart';
import 'gender.dart';
import 'grade.dart';
import 'i_student_repository.dart';
import 'occupation.dart';
import '../../account/password.dart';
import 'school_name.dart';
import 'student.dart';
import 'student_id.dart';
import 'student_name.dart';

class IStudentFactory {
  final IAccountRepository _repository;

  IStudentFactory(this._repository);

  Student createwithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) {
    final studentName = StudentName(WordPair.random().asLowerCase);
    // TODO: 学校名をどうとってくるかは考慮の余地あり
    final schoolName = SchoolName.others();

    var studentId = StudentId(const Uuid().v4());
    while (_repository.findById(studentId) != null) {
      studentId = StudentId(const Uuid().v4());
    }

    return Student(
      studentId: studentId,
      password: password,
      isauthenticated: false,
      emailAddress: emailAddress,
      studentName: studentName,
      profilePhoto: null,
      gender: Gender.nonAnswer,
      occupation: Occupation.others,
      schoolName: schoolName,
      grade: Grade.other,
    );
  }
}
