import 'package:studyhub/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';

import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_list.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_sender_type.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../student/in_memory_student_repository.dart';
import 'exception/notification_infrastructure_exception.dart';
import 'exception/notification_infrastructure_exception_detail.dart';

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
      InMemoryNotificationIdInitialValue.firstNotificationToStudentId:
          InMemoryNotificationInitialValue.firstNotificationToStudent,
      InMemoryNotificationIdInitialValue.firstNotificationToTeacherId:
          InMemoryNotificationInitialValue.firstNotificationToTeacher,
    };
    _id = 1000000;
  }

  @override
  Future<void> save(final Notification notification) async {
    if (store.containsKey(notification.notificationId)) {
      throw const NotificationInfrastructureException(
          NotificationInfrastructureExceptionDetail.idAlreadyExist);
    }
    store[notification.notificationId] = notification;
  }

  @override
  Future<NotificationId> generateId() async {
    final notificationId = _id.toString().padLeft(NotificationId.minLength);

    _id++;

    return NotificationId(notificationId);
  }
}

class InMemoryNotificationIdInitialValue {
  static final firstNotificationToStudentId =
      NotificationId('00000000000000000001');
  static final firstNotificationToTeacherId =
      NotificationId('00000000000000000002');
}

class InMemoryNotificationInitialValue {
  static final firstNotificationToStudent = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationToStudentId,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon.jpg'),
    ),
    receiverList: NotificationReceiverList([
      NotificationReceiver(
        receiverType: NotificationReceiverType.student,
        receiverId: InMemoryStudentInitialValue.userStudentId,
      ),
      NotificationReceiver(
        receiverType: NotificationReceiverType.student,
        receiverId: InMemoryStudentInitialValue.student1.studentId,
      ),
      NotificationReceiver(
        receiverType: NotificationReceiverType.student,
        receiverId: InMemoryStudentInitialValue.student2.studentId,
      ),
      NotificationReceiver(
        receiverType: NotificationReceiverType.student,
        receiverId: InMemoryStudentInitialValue.student3.studentId,
      ),
    ]),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText(
        'この度はアプリを入れていただきありがとうございます。今後皆様の満足感を挙げるために、アンケートにご協力お願いします。'),
    postedAt: DateTime.now(),
  );

  static final firstNotificationToTeacher = Notification(
    notificationId:
        InMemoryNotificationIdInitialValue.firstNotificationToTeacherId,
    sender: NotificationSender(
      senderType: NotificationSenderType.admin,
      senderId: null,
      // TODO: photoPath for admin
      senderPhotoPath:
          ProfilePhotoPath('assets/photos/profile_photo/sample_user_icon.jpg'),
    ),
    receiverList: NotificationReceiverList([
      NotificationReceiver(
        receiverType: NotificationReceiverType.teacher,
        receiverId: InMemoryTeacherInitialValue.teacher1.teacherId,
      ),
      NotificationReceiver(
        receiverType: NotificationReceiverType.teacher,
        receiverId: InMemoryTeacherInitialValue.teacher2.teacherId,
      ),
      NotificationReceiver(
        receiverType: NotificationReceiverType.teacher,
        receiverId: InMemoryTeacherInitialValue.teacher3.teacherId,
      ),
    ]),
    target: NotificationTarget(
      targetType: NotificationTargetType.info,
      targetId: null,
    ),
    title: NotificationTitle('運営からのお知らせ'),
    text: NotificationText('この度はご協力くださり、誠にありがとうございます。'),
    postedAt: DateTime.now(),
  );
}
