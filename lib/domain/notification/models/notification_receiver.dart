import '../../shared/id.dart';
import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';
import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';
import 'notification_receiver_type.dart';

class NotificationReceiver {
  final NotificationReceiverType _receiverType;
  final Id _receiverId;

  NotificationReceiver({
    required final NotificationReceiverType receiverType,
    required final Id receiverId,
  })  : _receiverType = receiverType,
        _receiverId = receiverId {
    _validate(receiverType: receiverType, receiverId: receiverId);
  }

  void _validate({
    required final NotificationReceiverType receiverType,
    required final Id receiverId,
  }) {
    switch (receiverType) {
      case NotificationReceiverType.student:
        if (_receiverId is! StudentId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.receiverTypeMismatched);
        }
      case NotificationReceiverType.teacher:
        if (_receiverId is! TeacherId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.receiverTypeMismatched);
        }
      default:
        throw const NotificationDomainException(
            NotificationDomainExceptionDetail.receiverTypeMismatched);
    }
  }

  NotificationReceiverType get receiverType => _receiverType;
  Id get receiverId => _receiverId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is NotificationReceiver) {
      return runtimeType == other.runtimeType &&
          _receiverType == other._receiverType &&
          _receiverId == other._receiverId;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => _receiverId.hashCode;
}
