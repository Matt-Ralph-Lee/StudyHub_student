import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/notification/models/i_notification_repository.dart';
import '../../../domain/notification/models/notification.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_receiver.dart';
import '../../../domain/notification/models/notification_receiver_type.dart';
import '../../../domain/notification/models/notification_sender_type.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/notification/notification_infrastructure_exception.dart';
import '../../exceptions/notification/notification_infrastructure_exception_detail.dart';

class FirebaseNotificationRepository implements INotificationRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseNotificationRepository _instance =
      FirebaseNotificationRepository._internal();

  factory FirebaseNotificationRepository() {
    return _instance;
  }

  FirebaseNotificationRepository._internal();

  @override
  Future<NotificationId> generateId(NotificationReceiver receiver) async {
    if (receiver.receiverType == NotificationReceiverType.student) {
      final docRef = db.collection("students").doc(receiver.receiverId.value);
      final id = docRef.id;

      return NotificationId(id);
    }
    if (receiver.receiverType == NotificationReceiverType.teacher) {
      final docRef = db.collection("teachers").doc(receiver.receiverId.value);
      final id = docRef.id;
      return NotificationId(id);
    }
    throw const NotificationInfrastructureException(
        NotificationInfrastructureExceptionDetail.invalidReceiverType);
  }

  @override
  Future<void> save(List<Notification> notifications) async {
    for (final notification in notifications) {
      final DocumentReference<Map<String, dynamic>> docRef;
      if (notification.receiver.receiverType ==
          NotificationReceiverType.student) {
        docRef = db
            .collection("students")
            .doc(notification.receiver.receiverId.value)
            .collection("notification")
            .doc(notification.notificationId.value);
      } else if (notification.receiver.receiverType ==
          NotificationReceiverType.teacher) {
        docRef = db
            .collection("teachers")
            .doc(notification.receiver.receiverId.value)
            .collection("notification")
            .doc(notification.notificationId.value);
      } else {
        throw const NotificationInfrastructureException(
            NotificationInfrastructureExceptionDetail.invalidReceiverType);
      }
      final addData = <String, dynamic>{};

      final senderType = switch (notification.sender.senderType) {
        NotificationSenderType.admin => "admin",
        NotificationSenderType.student => "student",
        NotificationSenderType.teacher => "teacher",
      };
      addData["senderType"] = senderType;

      if (notification.sender.senderType != NotificationSenderType.admin) {
        addData["senderId"] = notification.sender.senderId!.value;
      }

      addData["senderPhotoPath"] = notification.sender.senderPhotoPath.value;

      final targetType = switch (notification.target.targetType) {
        NotificationTargetType.info => "info",
        NotificationTargetType.answered => "answered",
        NotificationTargetType.questioned => "questioned"
      };
      final targetId = notification.target.targetId?.value;

      addData["targetType"] = targetType;
      addData["targetId"] = targetId;

      addData["title"] = notification.title.value;
      addData["text"] = notification.text.value;
      addData["posted"] = FieldValue.serverTimestamp();

      addData["read"] = notification.read;

      await docRef.set(addData);
    }
  }

  @override
  Future<bool> checkNotificationExistence(StudentId studentId) async {
    final querySnapshot = await db
        .collection("students")
        .doc(studentId.value)
        .collection("notification")
        .where("read", isEqualTo: true)
        .count()
        .get();
    if (querySnapshot.count == null) return false;
    return querySnapshot.count! > 0;
  }

  @override
  Future<void> readNotification(NotificationId id, StudentId studentId) async {
    await db
        .collection("students")
        .doc(studentId.value)
        .collection("notification")
        .doc(id.value)
        .update({"read": true});
  }
}
