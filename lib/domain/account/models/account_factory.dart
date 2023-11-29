import 'package:uuid/uuid.dart';

import '../../student/models/i_student_repository.dart';
import 'account.dart';
import '../../student/models/student_id.dart';
import 'email_address.dart';
import 'password.dart';

class AccountFactory {
  final IStudentRepository _repository;

  AccountFactory(this._repository);

  Account createwithEmailAndPassword({
    required final EmailAddress emailAddress,
    required final Password password,
  }) {
    var studentId = StudentId(const Uuid().v4());
    while (_repository.findById(studentId) != null) {
      studentId = StudentId(const Uuid().v4());
    }

    return Account(
      emailAddress: emailAddress,
      password: password,
      studentId: studentId,
    );
  }
}
