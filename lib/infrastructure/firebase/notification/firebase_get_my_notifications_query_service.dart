import 'package:cloud_firestore/cloud_firestore.dart';

import '../database.dart';

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
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import '../../../domain/photo/models/photo_path.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/shared/id.dart';
import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../exceptions/notification/notification_infrastructure_exception.dart';
import '../../exceptions/notification/notification_infrastructure_exception_detail.dart';

class FirebaseGetMyNotificationsQueryService
    implements IGetMyNotificationsQueryService {
  final db = Database.db;
  @override
  Future<List<GetMyNotificationDto>> get(StudentId studentId) async {
    final querySnapshot = await db
        .collection("students")
        .doc(studentId.value)
        .collection("notification")
        .get();

    final dtoList = <GetMyNotificationDto>[];

    for (final docSnapshot in querySnapshot.docs) {
      final doc = docSnapshot.data();

      final notificationIdData = docSnapshot.reference.id;
      final notificationId = NotificationId(notificationIdData);

      final senderTypeData = doc["senderType"];
      final senderIdData = doc["senderId"];
      final senderPhotoPathData = doc["senderPhotoPath"];

      final Id? senderId;
      final PhotoPath senderPhotoPath;
      final NotificationSenderType senderType;

      if (senderTypeData == "admin") {
        senderType = NotificationSenderType.admin;
        senderId = null;
        senderPhotoPath = ProfilePhotoPath(senderPhotoPathData);
      } else if (senderTypeData == "student") {
        senderType = NotificationSenderType.student;
        senderId = StudentId(senderIdData);
        senderPhotoPath = ProfilePhotoPath(senderPhotoPathData);
      } else if (senderTypeData == "teacher") {
        senderType = NotificationSenderType.teacher;
        senderId = TeacherId(senderIdData);
        senderPhotoPath = ProfilePhotoPath(senderPhotoPathData);
      } else {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.invalidSenderType);
      }

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
      final subTargetIdData = doc["subTargetId"];

      NotificationTargetType targetType;
      Id? targetId;
      Id? subTargetId;

      if (targetTypeData == "info") {
        targetType = NotificationTargetType.info;
        targetId = null;
        subTargetId = null;
      } else if (targetTypeData == "answered") {
        targetType = NotificationTargetType.answered;
        targetId = AnswerId(targetIdData);
        subTargetId = QuestionId(subTargetIdData);
      } else if (targetTypeData == "questioned") {
        targetType = NotificationTargetType.questioned;
        targetId = QuestionId(targetIdData);
        subTargetId = null;
      } else {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.invalidTargetType);
      }

      final titleData = doc["title"];
      final textData = doc["text"];

      final title = NotificationTitle(titleData);
      final text = NotificationText(textData);

      final postedAt = (doc["posted"] as Timestamp).toDate();

      final read = doc["read"];

      final target = NotificationTarget(
        targetType: targetType,
        targetId: targetId,
        subTargetId: subTargetId,
      );

      final notification = Notification(
        notificationId: notificationId,
        sender: sender,
        receiver: receiver,
        target: target,
        title: title,
        text: text,
        postedAt: postedAt,
        read: read,
      );

      dtoList.add(GetMyNotificationDto(
        type: notification.target.targetType,
        id: notification.notificationId,
        senderId: notification.sender.senderId,
        senderPhotoPath: notification.sender.senderPhotoPath.value,
        targetId: notification.target.targetId,
        subTargetId: notification.target.subTargetId,
        title: notification.title.value,
        text: notification.text.value,
        postedAt: notification.postedAt,
        read: notification.read,
      ));
    }

    return dtoList;
  }
}
