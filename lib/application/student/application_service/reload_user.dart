import '../../../domain/student_auth/models/i_student_auth_repository.dart';

class ReloadUser {
  final IStudentAuthRepository _repository;

  ReloadUser(this._repository);

  Future<void> execute() async {
    await _repository.reloadUser();
  }
}
