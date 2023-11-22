import 'account.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IAccountFactory {
  Future<Account> create({
    required final EmailAddress emailAddress,
    required final Password password,
  });
}
