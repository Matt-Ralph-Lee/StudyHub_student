import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';

class StudentAuthInfoWithoutPassword {
  final StudentId _studentId;
  final EmailAddress _emailAddress;
  final bool _isVerified;

  StudentId get studentId => _studentId;
  EmailAddress get emailAddress => _emailAddress;
  bool get isVerified => _isVerified;

  StudentAuthInfoWithoutPassword({
    required final StudentId studentId,
    required final EmailAddress emailAddress,
    required final bool isVerified,
  })  : _studentId = studentId,
        _emailAddress = emailAddress,
        _isVerified = isVerified;
}
