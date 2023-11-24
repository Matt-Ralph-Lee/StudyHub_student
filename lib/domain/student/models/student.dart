import 'email_address.dart';
import 'student_id.dart';

class Student {
  final StudentId _accountId;
  EmailAddress _emailAddress;

  StudentId get accountId => _accountId;
  EmailAddress get emailAddress => _emailAddress;

  Student({
    required final StudentId accountId,
    required final EmailAddress emailAddress,
  })  : _accountId = accountId,
        _emailAddress = emailAddress;

  void changeEmailAddress(EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }
}
