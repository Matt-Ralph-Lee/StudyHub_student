import '../../student/models/student_id.dart';
import 'email_address.dart';
import 'password.dart';

class Account {
  final EmailAddress _emailAddress;
  final Password _password;
  StudentId _studentId;

  EmailAddress get emailAddress => _emailAddress;
  Password get password => _password;
  StudentId get studentId => _studentId;

  Account({
    required final EmailAddress emailAddress,
    required final Password password,
    required final StudentId studentId,
  })  : _emailAddress = emailAddress,
        _password = password,
        _studentId = studentId;
}
