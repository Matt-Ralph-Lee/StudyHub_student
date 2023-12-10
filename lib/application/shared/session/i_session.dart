import '../../../domain/student/models/student_id.dart';
import 'session_role.dart';

abstract class ISession {
  final StudentId _studentId;
  final SessionRole _sessionRole;
  final bool _isVerified;

  StudentId get studentId => _studentId;
  SessionRole get sessionRole => _sessionRole;
  bool get isVerified => _isVerified;

  ISession(this._studentId, this._sessionRole, this._isVerified);
}
