import '../../answer_list/models/answer_id.dart';
import '../../question/models/question_id.dart';
import '../../shared/id.dart';
import '../exception/notification_domain_exception.dart';
import '../exception/notification_domain_exception_detail.dart';
import 'notification_target_type.dart';

class NotificationTarget {
  final NotificationTargetType _targetType;
  final Id? _targetId;
  final Id? _subTargetId;

  NotificationTargetType get targetType => _targetType;
  Id? get targetId => _targetId;
  Id? get subTargetId => _subTargetId;

  NotificationTarget({
    required final NotificationTargetType targetType,
    required final Id? targetId,
    required final Id? subTargetId,
  })  : _targetType = targetType,
        _targetId = targetId,
        _subTargetId = subTargetId {
    _validate(
      targetType: targetType,
      targetId: targetId,
      subTargetId: subTargetId,
    );
  }

  void _validate({
    required final NotificationTargetType targetType,
    required final Id? targetId,
    required final Id? subTargetId,
  }) {
    switch (targetType) {
      case NotificationTargetType.info:
        if (targetId != null || subTargetId != null) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
        break;
      case NotificationTargetType.questioned:
        if (targetId is! QuestionId || subTargetId != null) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
        break;
      case NotificationTargetType.answered:
        if (targetId is! AnswerId || subTargetId is! QuestionId) {
          throw const NotificationDomainException(
              NotificationDomainExceptionDetail.targetTypeMismatched);
        }
        break;
      default:
        throw const NotificationDomainException(
            NotificationDomainExceptionDetail.targetTypeMismatched);
    }
  }
}
