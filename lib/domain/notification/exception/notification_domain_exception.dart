import '../../shared/domain_exception.dart';
import 'notification_domain_exception_detail.dart';

class NotificationDomainException extends DomainException {
  const NotificationDomainException(
    NotificationDomainExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
