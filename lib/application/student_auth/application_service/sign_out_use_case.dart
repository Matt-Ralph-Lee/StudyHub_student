import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../shared/session/i_session.dart';

class SignOutUseCase {
  final IStudentAuthRepository _repository;
  final ISession _session;
  SignOutUseCase({
    required final IStudentAuthRepository repository,
    required final ISession session,
  })  : _repository = repository,
        _session = session;

  void execute() {
    final studentId = _session.studentId;
    _repository.signOut(studentId);
  }
}
