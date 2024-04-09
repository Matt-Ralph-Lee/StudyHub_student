import '../../shared/exception/use_case_exception.dart';
import 'notification_use_case_exception_detail.dart';

class NotificationUseCaseException extends UseCaseException {
  const NotificationUseCaseException(
    NotificationUseCaseExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
