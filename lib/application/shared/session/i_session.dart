import '../../../domain/student/models/student_id.dart';

abstract class ISession {
  final StudentId _studentId;
  final bool _isVerified;

  StudentId get studentId => _studentId;
  bool get isVerified => _isVerified;

  ISession(this._studentId, this._isVerified);
}
