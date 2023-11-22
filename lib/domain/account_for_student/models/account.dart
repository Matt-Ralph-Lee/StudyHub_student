import 'email_address.dart';
import 'account_id.dart';

class Account {
  final AccountId _accountId;
  EmailAddress _emailAddress;

  AccountId get accountId => _accountId;
  EmailAddress get emailAddress => _emailAddress;

  Account({
    required final AccountId accountId,
    required final EmailAddress emailAddress,
  })  : _accountId = accountId,
        _emailAddress = emailAddress;

  void changeEmailAddress(EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }
}
