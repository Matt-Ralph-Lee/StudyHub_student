import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../shared/session/i_session.dart';

class PasswordUpdateUseCase {
  final IStudentAuthRepository _authRepository;
  final ISession _session;
  PasswordUpdateUseCase({
    required final IStudentAuthRepository authRepository,
    required final ISession session,
  })  : _authRepository = authRepository,
        _session = session;

  void execute(final String currentPasswordData, final String newPasswordData) {
    final studentId = _session.studentId;
    final currentPassword = Password(currentPasswordData);
    final newPassword = Password(newPasswordData);

    _authRepository.updatePassword(
      studentId: studentId,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
