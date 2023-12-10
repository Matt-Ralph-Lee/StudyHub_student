import '../../student/models/student_id.dart';
import 'email_address.dart';
import 'password.dart';

class StudentAuthInfo {
  final StudentId _studentId;
  EmailAddress _emailAddress;
  Password _password;
  bool _isVerified;

  StudentId get studentId => _studentId;
  EmailAddress get emailAddress => _emailAddress;
  Password get password => _password;
  bool get isVerified => _isVerified;

  StudentAuthInfo({
    required final StudentId studentId,
    required final EmailAddress emailAddress,
    required final Password password,
    required final bool isVerified,
  })  : _studentId = studentId,
        _emailAddress = emailAddress,
        _password = password,
        _isVerified = isVerified;

  void changeEmailAddress(final EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
    _isVerified = false;
  }

  void changePassword(final Password newPassword) {
    _password = newPassword;
  }
}
