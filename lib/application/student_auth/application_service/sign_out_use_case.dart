import '../../../domain/student_auth/models/i_student_auth_repository.dart';

class SignOutUseCase {
  final IStudentAuthRepository _repository;
  SignOutUseCase({
    required final IStudentAuthRepository repository,
  }) : _repository = repository;

  Future<void> execute() async {
    await _repository.signOut();
  }
}
