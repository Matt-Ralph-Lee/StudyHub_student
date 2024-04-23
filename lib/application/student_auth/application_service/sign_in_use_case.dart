import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../interfaces/i_logger.dart';

class SignInUseCase {
  final IStudentAuthRepository _repository;
  final ILogger _logger;

  SignInUseCase({
    required final IStudentAuthRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    _logger.info('BEGIN $SignInUseCase.execute()');

    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    await _repository.signIn(emailAddress: emailAddress, password: password);

    _logger.info('END $SignInUseCase.execute()');
  }
}
