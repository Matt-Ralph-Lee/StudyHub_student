import '../../../domain/notification/models/i_notification_factory.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_receiver_list.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import 'in_memory_notification_repository.dart';

class InMemoryNotificationFactory implements INotificationFactory {
  final InMemoryNotificationRepository _repository;

  InMemoryNotificationFactory({
    required final InMemoryNotificationRepository repository,
  }) : _repository = repository;

  @override
  Future<Notification> create({
    required final NotificationSender sender,
    required final NotificationReceiverList receiverList,
    required final NotificationTarget target,
    required final NotificationTitle title,
    required final NotificationText text,
    required final DateTime postedAt,
    required final bool read,
  }) async {
    final notificationId = await _repository.generateId();

    return Notification(
      notificationId: notificationId,
      sender: sender,
      receiverList: receiverList,
      target: target,
      title: title,
      text: text,
      postedAt: postedAt,
      read: read,
    );
  }
}
