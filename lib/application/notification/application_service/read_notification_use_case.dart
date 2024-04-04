import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification_id.dart';

class ReadNotificationUseCase {
  final INotificationRepository _repository;

  ReadNotificationUseCase(this._repository);

  void execute(final NotificationId id) {
    _repository.readNotification(id);
  }
}
