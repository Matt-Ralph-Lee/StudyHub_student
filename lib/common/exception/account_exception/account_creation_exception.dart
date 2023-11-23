import '../generic_exception.dart';
import 'account_creation_exception_detail.dart';

class AccountCreationException extends GenericException {
  const AccountCreationException(
    AccountCreationExceptionDetail detail, {
    dynamic info,
  }) : super(detail, info: info);
}
