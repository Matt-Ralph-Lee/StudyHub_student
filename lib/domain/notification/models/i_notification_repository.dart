import 'notification.dart';
import 'notification_id.dart';
import 'notification_receiver.dart';

abstract class INotificationRepository {
  Future<void> save(final List<Notification> notifications);
  Future<NotificationId> generateId(final NotificationReceiver receiver);
}
