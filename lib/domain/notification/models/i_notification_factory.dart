import 'notification_receiver_list.dart';
import 'notification_sender.dart';
import 'notification_target.dart';
import 'notification_text.dart';
import 'notification_title.dart';
import 'notification.dart';

abstract class INotificationFactory {
  Future<Notification> create({
    required final NotificationSender sender,
    required final NotificationReceiverList receiverList,
    required final NotificationTarget target,
    required final NotificationTitle title,
    required final NotificationText text,
    required final DateTime postedAt,
  });
}
