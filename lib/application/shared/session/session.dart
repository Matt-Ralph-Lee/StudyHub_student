import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/models/email_address.dart';

class Session {
  final StudentId _studentId;
  final EmailAddress _emailAddress;
  final bool _isVerified;

  StudentId get studentId => _studentId;
  EmailAddress get emailAddress => _emailAddress;
  bool get isVerified => _isVerified;

  Session(this._studentId, this._isVerified, this._emailAddress);
}
