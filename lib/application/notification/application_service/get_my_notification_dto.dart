import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_sender.dart';
import '../../../domain/notification/models/notification_target.dart';

class GetMyNotificationDto {
  final NotificationId id;
  final NotificationSender sender;
  final NotificationTarget target;
  final String title;
  final String text;

  GetMyNotificationDto({
    required this.id,
    required this.sender,
    required this.target,
    required this.title,
    required this.text,
  });
}
