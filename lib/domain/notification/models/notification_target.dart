import '../../answer_list/models/answer_id.dart';
import '../../question/models/question_id.dart';
import '../../shared/id.dart';
import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';
import 'notification_target_type.dart';

class NotificationTarget {
  final NotificationTargetType _targetType;
  final Id? _targetId;

  NotificationTargetType get targetType => _targetType;
  Id? get targetId => _targetId;

  NotificationTarget({
    required final NotificationTargetType targetType,
    required final Id? targetId,
  })  : _targetType = targetType,
        _targetId = targetId {
    _validate(targetType: targetType, targetId: targetId);
  }

  void _validate({
    required final NotificationTargetType targetType,
    required final Id? targetId,
  }) {
    switch (targetType) {
      case NotificationTargetType.info:
        if (_targetId != null) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
      case NotificationTargetType.questioned:
        if (_targetId is! QuestionId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
      case NotificationTargetType.answered:
        if (_targetId is! AnswerId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
      default:
        throw const NotificationDomainException(
            NotificationDomainExceptionDetail.targetTypeMismatched);
    }
  }
}
