import '../../../domain/notification/models/i_notification_factory.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import 'firebase_notification_repository.dart';

class FirebaseNotificationFactory implements INotificationFactory {
  final FirebaseNotificationRepository _repository;

  FirebaseNotificationFactory(this._repository);

  @override
  Future<Notification> create({
    required NotificationSender sender,
    required NotificationReceiver receiver,
    required NotificationTarget target,
    required NotificationTitle title,
    required NotificationText text,
    required DateTime postedAt,
    required bool read,
  }) async {
    final notificationId = await _repository.generateId(receiver);
    return Notification(
      notificationId: notificationId,
      sender: sender,
      receiver: receiver,
      target: target,
      title: title,
      text: text,
      postedAt: postedAt,
      read: read,
    );
  }
}
