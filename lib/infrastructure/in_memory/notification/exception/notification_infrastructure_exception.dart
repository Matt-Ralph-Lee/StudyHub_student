import '../../../shared/infrastructure_exception.dart';
import 'notification_infrastructure_exception_detail.dart';

class NotificationInfrastructureException extends InfrastructureException {
  const NotificationInfrastructureException(
    NotificationInfrastructureExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
