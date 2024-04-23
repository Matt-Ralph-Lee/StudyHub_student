import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../interfaces/i_logger.dart';

class SignOutUseCase {
  final IStudentAuthRepository _repository;
  final ILogger _logger;

  SignOutUseCase({
    required final IStudentAuthRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute() async {
    _logger.info('BEGIN $SignOutUseCase.execute()');

    await _repository.signOut();

    _logger.info('END $SignOutUseCase.execute()');
  }
}
