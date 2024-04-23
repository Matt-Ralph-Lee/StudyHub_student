import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../interfaces/i_logger.dart';
import 'update_student_auth_info_command.dart';

class UpdateStudentAuthInfoUseCase {
  final IStudentAuthRepository _repository;
  final ILogger _logger;

  UpdateStudentAuthInfoUseCase({
    required final IStudentAuthRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute(final UpdateStudentAuthInfoCommand command) async {
    _logger.info('BEGIN $UpdateStudentAuthInfoUseCase.execute()');

    final emailAddressData = command.emailAddress;
    final emailAddressToResetPassword = command.emailAddressToResetPassword;

    if (emailAddressData != null) {
      final emailAddress = EmailAddress(emailAddressData);
      await _repository.updateEmailAddress(emailAddress);
    }

    if (emailAddressToResetPassword != null) {
      final emailAddress = EmailAddress(emailAddressToResetPassword);
      await _repository.sendPasswordResetEmail(emailAddress: emailAddress);
    }

    _logger.info('END $UpdateStudentAuthInfoUseCase.execute()');
  }
}
