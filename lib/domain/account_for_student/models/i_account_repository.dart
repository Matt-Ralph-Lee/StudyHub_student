import 'account.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IAccountRepository {
  Future<void> save(final Account account);

  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });

  Future<void> signOut();

  Account? findByEmailAddress(final EmailAddress emailAddress);
  Stream<Account?> accountStateChanges();
}
