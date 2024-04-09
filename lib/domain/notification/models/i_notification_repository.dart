import '../../student/models/student_id.dart';
import 'notification.dart';
import 'notification_id.dart';
import 'notification_receiver.dart';

abstract class INotificationRepository {
  Future<void> readNotification(
      final NotificationId id, final StudentId studentId);
  Future<bool> checkNotificationExistence(final StudentId studentId);
  Future<void> save(final List<Notification> notifications);
  Future<NotificationId> generateId(final NotificationReceiver receiver);
}
