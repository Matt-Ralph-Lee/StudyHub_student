import '../generic_exception.dart';
import 'argument_exception_detail.dart';

class ArgumentException extends GenericException {
  const ArgumentException(
    ArgumentExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
