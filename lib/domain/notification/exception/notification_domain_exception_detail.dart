import '../../shared/domain_exception_detail.dart';
import '../models/notification_id.dart';
import '../models/notification_text.dart';
import '../models/notification_title.dart';

enum NotificationDomainExceptionDetail implements DomainExceptionDetail {
  invalidNotificationIdLength(
      'notification id must be longer than or equal to ${NotificationId.minLength}'),
  invalidPhotoPath('photo path format is invalid'),
  invalidTitleLength(
      'notification title must be ${NotificationTitle.minLength}-${NotificationTitle.maxLength} characters long'),
  invalidTextLength(
      'notification title must be shorter than or equal to ${NotificationText.maxLength} characters'),
  empty('must not be empty'),
  invalidTextLine(
      'notification text must be within ${NotificationText.maxLine} lines'),
  senderTypeMismatched('sender type mismatched'),
  receiverTypeMismatched('receiver type mismatched'),
  targetTypeMismatched('target type mismatched'),
  ;

  const NotificationDomainExceptionDetail(this._message);

  final String _message;

  @override
  String get message => _message;
}
