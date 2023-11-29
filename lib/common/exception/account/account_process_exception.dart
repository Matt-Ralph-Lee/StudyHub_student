import '../generic_exception.dart';
import 'account_process_exception_detail.dart';

class AccountProcessException extends GenericException {
  const AccountProcessException(
    AccountProcessExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
