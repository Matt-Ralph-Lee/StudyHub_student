import 'account.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IAccountRepository {
  void save(final Account account);
  bool emailAddressExists(final EmailAddress emailAddress);
  Account signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  void signOut();
  Stream<Account?> getCurrentAccount();
}
