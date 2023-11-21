import 'email_address.dart';
import 'user_id.dart';

class Account {
  final UserId _userId;
  EmailAddress _emailAddress;

  UserId get userId => _userId;
  EmailAddress get emailAddress => _emailAddress;

  Account({
    required final UserId userId,
    required final EmailAddress emailAddress,
  })  : _userId = userId,
        _emailAddress = emailAddress;

  void changeEmailAddress(EmailAddress newEmailAddress) {
    _emailAddress = newEmailAddress;
  }
}
