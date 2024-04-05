import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../../application/notification/application_service/i_get_my_notifications_query_service.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/student/models/student_id.dart';
import 'in_memory_notification_repository.dart';

class InMemoryGetMyNotificationsQueryService
    implements IGetMyNotificationsQueryService {
  final InMemoryNotificationRepository _repository;

  InMemoryGetMyNotificationsQueryService({
    required final InMemoryNotificationRepository repository,
  }) : _repository = repository;

  @override
  Future<List<GetMyNotificationDto>> get(final StudentId studentId) async {
    final myNotificationList = _repository.store.values.where((notification) =>
        notification.receiverList.contains(NotificationReceiver(
          receiverType: NotificationReceiverType.student,
          receiverId: studentId,
        )));
    return myNotificationList
        .map((notification) => GetMyNotificationDto(
              id: notification.notificationId,
              sender: notification.sender,
              target: notification.target,
              title: notification.title.value,
              text: notification.text.value,
              postedAt: notification.postedAt,
              read: notification.read,
            ))
        .toList();
  }
}
