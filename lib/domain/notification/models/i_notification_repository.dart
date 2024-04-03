import 'notification.dart';
import 'notification_id.dart';

abstract class INotificationRepository {
  Future<void> save(final Notification notification);
  Future<NotificationId> generateId();
}
