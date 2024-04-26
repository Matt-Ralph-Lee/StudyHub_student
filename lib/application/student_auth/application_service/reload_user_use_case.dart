import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../interfaces/i_logger.dart';

class ReloadUserUseCase {
  final IStudentAuthRepository _repository;
  final ILogger _logger;

  ReloadUserUseCase({
    required final IStudentAuthRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute() async {
    _logger.info('BEGIN $ReloadUserUseCase.execute()');

    await _repository.reloadUser();

    _logger.info('END $ReloadUserUseCase.execute()');
  }
}
