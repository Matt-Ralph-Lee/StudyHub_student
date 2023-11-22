import 'account.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IAccountRepository {
  Future<void> create({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  Future<void> signOut();
  Future<void> delete();
  Stream<Account?> accountStateChanges();
  Account? getCurrentAccount();
  Stream<bool> isSignedIn();
  Account? findByEmailAddress(final EmailAddress emailAddress);
  Future<void> resetPassword(final Password newPassword);
  Future<void> changeEmailAddress(final Account modifiedAccount);
}
