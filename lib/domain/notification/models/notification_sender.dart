import '../../photo/models/photo_path.dart';
import '../../shared/id.dart';
import '../../shared/profile_photo_path.dart';
import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';
import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';
import 'notification_sender_type.dart';

class NotificationSender {
  final NotificationSenderType _senderType;
  final Id? _senderId;
  final PhotoPath _senderPhotoPath;

  NotificationSenderType get senderType => _senderType;
  Id? get senderId => _senderId;
  PhotoPath get senderPhotoPath => _senderPhotoPath;

  NotificationSender({
    required final NotificationSenderType senderType,
    required final Id? senderId,
    required final PhotoPath senderPhotoPath,
  })  : _senderType = senderType,
        _senderId = senderId,
        _senderPhotoPath = senderPhotoPath {
    _validate(
      senderType: senderType,
      senderId: senderId,
      senderPhotoPath: senderPhotoPath,
    );
  }

  void _validate({
    required final NotificationSenderType senderType,
    required final Id? senderId,
    required final PhotoPath senderPhotoPath,
  }) {
    switch (senderType) {
      case NotificationSenderType.admin:
        if (_senderIdIsNotForAdmin(senderId)) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.senderTypeMismatched);
        }
      case NotificationSenderType.teacher:
        if (senderId is! TeacherId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.senderTypeMismatched);
        }
        if (_senderPhotoPath is! ProfilePhotoPath) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.senderTypeMismatched);
        }
      case NotificationSenderType.student:
        if (senderId is! StudentId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.senderTypeMismatched);
        }
        if (_senderPhotoPath is! ProfilePhotoPath) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.senderTypeMismatched);
        }
      default:
        throw const NotificationDomainException(
            NotificationDomainExceptionDetail.senderTypeMismatched);
    }
  }

  // check method when sender is admin (default: null check)
  // you can check it by giving admin a specific Id instead
  bool _senderIdIsNotForAdmin(final Id? senderId) {
    return senderId != null;
  }
}
