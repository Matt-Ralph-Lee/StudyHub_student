import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_target_type.dart';
import '../../../domain/shared/id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../exception/notification_use_case_exception.dart';
import '../exception/notification_use_case_exception_detail.dart';

class GetMyNotificationDto {
  final NotificationTargetType _type;
  final NotificationId _id;
  final Id? _senderId;
  final String _senderPhotoPath;
  final Id? _targetId;
  final String _title;
  final String _text;
  final DateTime _postedAt;
  final bool _read;

  NotificationTargetType get type => _type;
  NotificationId get id => _id;
  Id? get senderId => _senderId;
  String get senderPhotoPath => _senderPhotoPath;
  Id? get targetId => _targetId;
  String get title => _title;
  String get text => _text;
  DateTime get postedAt => _postedAt;
  bool get read => _read;

  GetMyNotificationDto({
    required final NotificationTargetType type,
    required final NotificationId id,
    required final Id? senderId,
    required final String senderPhotoPath,
    required final Id? targetId,
    required final String title,
    required final String text,
    required final DateTime postedAt,
    required final bool read,
  })  : _type = type,
        _id = id,
        _senderId = senderId,
        _senderPhotoPath = senderPhotoPath,
        _targetId = targetId,
        _title = title,
        _text = text,
        _postedAt = postedAt,
        _read = read {
    switch (type) {
      case NotificationTargetType.info:
        if (senderId != null || targetId != null) {
          throw const NotificationUseCaseException(
              NotificationUseCaseExceptionDetail.invalidDtoConstruction);
        }
      case NotificationTargetType.answered:
        if (senderId is! TeacherId || targetId is! AnswerId) {
          throw const NotificationUseCaseException(
              NotificationUseCaseExceptionDetail.invalidDtoConstruction);
        }
      default:
        throw const NotificationUseCaseException(
            NotificationUseCaseExceptionDetail.invalidDtoConstruction);
    }
  }
}
