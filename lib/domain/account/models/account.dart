import 'account_id.dart';
import 'email_address.dart';
import 'password.dart';

class Account {
  final AccountId _accountId;
  EmailAddress _emailAddress;
  Password _password;
  bool _isVerified;

  AccountId get accountId => _accountId;
  EmailAddress get emailAddress => _emailAddress;
  Password get password => _password;
  bool get isVerified => _isVerified;

  Account({
    required final AccountId accountId,
    required final EmailAddress emailAddress,
    required final Password password,
    required final bool isVerified,
  })  : _accountId = accountId,
        _emailAddress = emailAddress,
        _password = password,
        _isVerified = isVerified;

  void changeEmailAddress(final EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }

  void changePassword(final Password newPassword) {
    _password = newPassword;
  }
}
