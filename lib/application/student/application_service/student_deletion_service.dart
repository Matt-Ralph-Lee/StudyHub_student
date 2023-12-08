import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../student_auth/i_session.dart';

class StudentDeletionService {
  final IStudentAuthRepository _authRepository;
  final ISession _session;
  final IStudentRepository _repository;
  StudentDeletionService({
    required final IStudentAuthRepository authRepository,
    required final ISession session,
    required final IStudentRepository repository,
  })  : _repository = repository,
        _session = session,
        _authRepository = authRepository;

  void delete() {
    final studentId = _session.studentId;
    _repository.delete(studentId);
    _authRepository.delete(studentId);
  }
}
