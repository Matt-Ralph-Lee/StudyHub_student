import 'notification_receiver.dart';
import 'notification_sender.dart';
import 'notification_target.dart';
import 'notification_text.dart';
import 'notification_title.dart';
import 'notification.dart';

abstract class INotificationFactory {
  Future<Notification> create({
    required final NotificationSender sender,
    required final NotificationReceiver receiver,
    required final NotificationTarget target,
    required final NotificationTitle title,
    required final NotificationText text,
    required final DateTime postedAt,
    required final bool read,
  });
}
