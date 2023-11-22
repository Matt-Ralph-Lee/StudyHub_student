import 'generic_exception.dart';
import 'unknown_exception_detail.dart';

class UnknownException extends GenericException {
  const UnknownException(
    UnknownExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
