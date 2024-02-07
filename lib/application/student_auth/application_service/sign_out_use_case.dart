import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../shared/session/session.dart';

class SignOutUseCase {
  final IStudentAuthRepository _repository;
  final Session _session;
  SignOutUseCase({
    required final IStudentAuthRepository repository,
    required final Session session,
  })  : _repository = repository,
        _session = session;

  void execute() {
    final studentId = _session.studentId;
    _repository.signOut(studentId);
  }
}
