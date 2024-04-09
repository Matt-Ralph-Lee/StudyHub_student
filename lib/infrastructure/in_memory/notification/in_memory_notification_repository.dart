import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_sender_type.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../student/in_memory_student_repository.dart';
import '../../exceptions/notification/notification_infrastructure_exception.dart';
import '../../exceptions/notification/notification_infrastructure_exception_detail.dart';
import '../teacher/in_memory_teacher_repository.dart';

class InMemoryNotificationRepository implements INotificationRepository {
  late Map<NotificationId, Notification> store;
  late int _id;
  static final InMemoryNotificationRepository _instance =
      InMemoryNotificationRepository._internal();

  factory InMemoryNotificationRepository() {
    return _instance;
  }

  InMemoryNotificationRepository._internal() {
    store = {
      InMemoryNotificationIdInitialValue.firstNotificationIdToUserStudent:
          InMemoryNotificationInitialValue.firstNotificationToUserStudent,
      InMemoryNotificationIdInitialValue.firstNotificationIdToStudent1:
          InMemoryNotificationInitialValue.firstNotificationToStudent1,
      InMemoryNotificationIdInitialValue.firstNotificationIdToStudent2:
          InMemoryNotificationInitialValue.firstNotificationToStudent2,
      InMemoryNotificationIdInitialValue.firstNotificationIdToStudent3:
          InMemoryNotificationInitialValue.firstNotificationToStudent3,
      InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher1:
          InMemoryNotificationInitialValue.firstNotificationToTeacher1,
      InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher2:
          InMemoryNotificationInitialValue.firstNotificationToTeacher2,
      InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher3:
          InMemoryNotificationInitialValue.firstNotificationToTeacher3,
    };
    _id = 1000000;
  }

  @override
  Future<void> save(final List<Notification> notificationList) async {
    for (var notification in notificationList) {
      if (store.containsKey(notification.notificationId)) {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.idAlreadyExist);
      }
      store[notification.notificationId] = notification;
    }
  }

  @override
  Future<NotificationId> generateId(NotificationReceiver receiver) async {
    final notificationId = _id.toString().padLeft(NotificationId.minLength);

    _id++;

    return NotificationId(notificationId);
  }

  @override
  Future<void> readNotification(NotificationId id, StudentId studentId) async {
    final notification = store[id];
    if (notification == null) {
      throw const NotificationInfrastructureException(
          NotificationInfrastructureExceptionDetail.notificationNotFound);
    }
    store[id] = Notification(
      notificationId: notification.notificationId,
      sender: notification.sender,
      receiver: notification.receiver,
      target: notification.target,
      title: notification.title,
      text: notification.text,
      postedAt: notification.postedAt,
      read: true,
    );
  }

  @override
  Future<bool> checkNotificationExistence(StudentId studentId) async {
    final result = store.values.where((notification) =>
        !notification.read && notification.receiver.receiverId == studentId);

    return result.isEmpty;
  }
}

class InMemoryNotificationIdInitialValue {
  static final firstNotificationIdToUserStudent =
      NotificationId('00000000000000000010');
  static final firstNotificationIdToStudent1 =
      NotificationId('00000000000000000011');
  static final firstNotificationIdToStudent2 =
      NotificationId('00000000000000000012');
  static final firstNotificationIdToStudent3 =
      NotificationId('00000000000000000013');
  static final firstNotificationIdToTeacher1 =
      NotificationId('00000000000000000021');
  static final firstNotificationIdToTeacher2 =
      NotificationId('00000000000000000022');
  static final firstNotificationIdToTeacher3 =
      NotificationId('00000000000000000023');
}

class InMemoryNotificationInitialValue {
  static final firstNotificationToUserStudent = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToUserStudent,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.student,
      receiverId: InMemoryStudentInitialValue.student1.studentId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText(
        'この度はアプリを入れていただきありがとうございます。今後皆様の満足感を挙げるために、アンケートにご協力お願いします。'),
    postedAt: DateTime.now(),
    read: false,
  );

  static final firstNotificationToStudent1 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToStudent1,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.student,
      receiverId: InMemoryStudentInitialValue.userStudentId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText(
        'この度はアプリを入れていただきありがとうございます。今後皆様の満足感を挙げるために、アンケートにご協力お願いします。'),
    postedAt: DateTime.now(),
    read: false,
  );

  static final firstNotificationToStudent2 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToStudent2,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath: ProfilePhotoPath('assets/photos/sample_use_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.student,
      receiverId: InMemoryStudentInitialValue.student2.studentId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText(
        'この度はアプリを入れていただきありがとうございます。今後皆様の満足感を挙げるために、アンケートにご協力お願いします。'),
    postedAt: DateTime.now(),
    read: false,
  );

  static final firstNotificationToStudent3 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToStudent3,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath: ProfilePhotoPath('assets/photos/sample_use_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.student,
      receiverId: InMemoryStudentInitialValue.student3.studentId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText(
        'この度はアプリを入れていただきありがとうございます。今後皆様の満足感を挙げるために、アンケートにご協力お願いします。'),
    postedAt: DateTime.now(),
    read: true,
  );

  static final firstNotificationToTeacher1 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher1,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath: ProfilePhotoPath('assets/photos/sample_use_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.teacher,
      receiverId: InMemoryTeacherInitialValue.teacher1.teacherId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText('この度はご協力くださり、誠にありがとうございます。'),
    postedAt: DateTime.now(),
    read: false,
  );

  static final firstNotificationToTeacher2 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher2,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath: ProfilePhotoPath('assets/photos/sample_use_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.teacher,
      receiverId: InMemoryTeacherInitialValue.teacher2.teacherId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText('この度はご協力くださり、誠にありがとうございます。'),
    postedAt: DateTime.now(),
    read: false,
  );

  static final firstNotificationToTeacher3 = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationIdToTeacher3,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath: ProfilePhotoPath('assets/photos/sample_use_icon.jpg'),
    ),
    receiver: NotificationReceiver(
      receiverType: NotificationReceiverType.teacher,
      receiverId: InMemoryTeacherInitialValue.teacher3.teacherId,
    ),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText('この度はご協力くださり、誠にありがとうございます。'),
    postedAt: DateTime.now(),
    read: false,
  );
}
