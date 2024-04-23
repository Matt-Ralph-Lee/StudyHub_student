import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../interfaces/i_logger.dart';

class ResendVerificationEmailUseCase {
  final IStudentAuthRepository _repository;
  final ILogger _logger;

  ResendVerificationEmailUseCase({
    required final IStudentAuthRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute(final String emailAddressData) async {
    _logger.info('BEGIN $ResendVerificationEmailUseCase.execute()');

    await _repository.sendEmailVerification();

    _logger.info('END $ResendVerificationEmailUseCase.execute()');
  }
}
