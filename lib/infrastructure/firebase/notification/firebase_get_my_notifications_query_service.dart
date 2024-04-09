import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/notification/application_service/get_my_notification_dto.dart';
import '../../../application/notification/application_service/i_get_my_notifications_query_service.dart';
import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_sender_type.dart';
import '../../../domain/notification/models/notification_target.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/shared/id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/notification/notification_infrastructure_exception.dart';
import '../../exceptions/notification/notification_infrastructure_exception_detail.dart';

class FirebaseGetMyNotificationsQueryService
    implements IGetMyNotificationsQueryService {
  final db = FirebaseFirestore.instance;
  @override
  Future<List<GetMyNotificationDto>> get(StudentId studentId) async {
    final querySnapshot = await db
        .collection("students")
        .doc(studentId.value)
        .collection("notification")
        .get();

    final myNotificationList = <Notification>[];

    for (final docSnapshot in querySnapshot.docs) {
      final doc = docSnapshot.data();

      final notificationIdData = docSnapshot.reference.id;
      final notificationId = NotificationId(notificationIdData);

      final senderTypeData = doc["senderType"];
      NotificationSenderType senderType;
      if (senderTypeData == "admin") {
        senderType = NotificationSenderType.admin;
      } else if (senderTypeData == "student") {
        senderType = NotificationSenderType.student;
      } else if (senderTypeData == "teacher") {
        senderType = NotificationSenderType.teacher;
      } else {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.invalidSenderType);
      }

      final senderId = doc["senderId"];
      final senderPhotoPath = doc["senderPhotoPath"];

      final sender = NotificationSender(
          senderType: senderType,
          senderId: senderId,
          senderPhotoPath: senderPhotoPath);

      const receiverType = NotificationReceiverType.student;
      final receiverId = studentId;

      final receiver = NotificationReceiver(
          receiverType: receiverType, receiverId: receiverId);

      final targetTypeData = doc["targetType"];
      final targetIdData = doc["targetId"];
      Id? targetId;
      NotificationTargetType targetType;
      if (targetTypeData == "info") {
        targetType = NotificationTargetType.info;
        targetId = null;
      } else if (targetTypeData == "answered") {
        targetType = NotificationTargetType.answered;
        targetId = AnswerId(targetIdData);
      } else if (targetTypeData == "questioned") {
        targetType = NotificationTargetType.questioned;
        targetId = QuestionId(targetIdData);
      } else {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.invalidTargetType);
      }

      final title = doc["title"];
      final text = doc["text"];
      final postedAt = (doc["postedAt"] as Timestamp).toDate();

      final target =
          NotificationTarget(targetType: targetType, targetId: targetId);

      myNotificationList.add(Notification(
          notificationId: notificationId,
          sender: sender,
          receiver: receiver,
          target: target,
          title: title,
          text: text,
          postedAt: postedAt));
    }

    final myNotificationDto = myNotificationList
        .map((notification) => GetMyNotificationDto(
            type: notification.target.targetType,
            id: notification.notificationId,
            senderId: notification.sender.senderId,
            senderPhotoPath: notification.sender.senderPhotoPath.value,
            targetId: notification.target.targetId,
            title: notification.title.value,
            text: notification.text.value,
            postedAt: notification.postedAt))
        .toList();

    return myNotificationDto;
  }
}
