import 'account_id.dart';
import 'email_address.dart';
import 'password.dart';

class Account {
  final AccountId _accountId;
  EmailAddress _emailAddress;
  Password _password;

  AccountId get accountId => _accountId;
  EmailAddress get emailAddress => _emailAddress;
  Password get password => _password;

  Account({
    required final AccountId accountId,
    required final EmailAddress emailAddress,
    required final Password password,
  })  : _accountId = accountId,
        _emailAddress = emailAddress,
        _password = password;

  void changeEmailAddress(final EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }

  void changePassword(final Password newPassword) {
    _password = newPassword;
  }
}
