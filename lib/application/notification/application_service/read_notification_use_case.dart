import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';

class ReadNotificationUseCase {
  final INotificationRepository _repository;
  final ILogger _logger;

  ReadNotificationUseCase({
    required final INotificationRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute({
    required final NotificationId id,
    required final StudentId studentId,
  }) async {
    _logger.info('BEGIN $ReadNotificationUseCase.execute()');

    await _repository.readNotification(id, studentId);

    _logger.info('END $ReadNotificationUseCase.execute()');
  }
}
