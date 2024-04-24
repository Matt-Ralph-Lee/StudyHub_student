import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';

class CheckNotificationExistenceUseCase {
  final INotificationRepository _repository;
  final ILogger _logger;

  CheckNotificationExistenceUseCase({
    required final INotificationRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<bool> execute(final StudentId studentId) async {
    _logger.info('BEGIN $CheckNotificationExistenceUseCase.execute()');

    final result = await _repository.checkNotificationExistence(studentId);

    _logger.info('END $CheckNotificationExistenceUseCase.execute()');
    return result;
  }
}
