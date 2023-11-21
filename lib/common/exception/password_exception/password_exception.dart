import '../generic_exception.dart';
import 'password_exception_detail.dart';

class PasswordException extends GenericException {
  const PasswordException(
    PasswordExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
