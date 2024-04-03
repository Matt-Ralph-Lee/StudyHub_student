import 'notification.dart';

abstract class INotificationRepository {
  Future<void> save(final List<Notification> notificationList);
}
