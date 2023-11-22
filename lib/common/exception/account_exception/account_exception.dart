import '../generic_exception.dart';
import 'account_exception_detail.dart';

class AccountException extends GenericException {
  const AccountException(
    AccountExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
