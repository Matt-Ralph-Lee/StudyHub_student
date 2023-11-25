import 'package:studyhub/domain/student/models/student_name.dart';

import 'email_address.dart';
import 'student_id.dart';

class Student {
  final StudentId _accountId;
  EmailAddress _emailAddress;
  StudentName _studentName;

  StudentId get accountId => _accountId;
  EmailAddress get emailAddress => _emailAddress;

  Student({
    required final StudentId accountId,
    required final EmailAddress emailAddress,
    required final StudentName studentName,
  })  : _accountId = accountId,
        _emailAddress = emailAddress,
        _studentName = studentName;

  void changeEmailAddress(EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }
}
