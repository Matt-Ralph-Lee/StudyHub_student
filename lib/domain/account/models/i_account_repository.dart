import '../../../application/account/account_dto.dart';
import 'account.dart';
import 'account_id.dart';
import 'email_address.dart';
import 'password.dart';

abstract class IAccountRepository {
  void create(final Account account);
  void signIn({
    required final EmailAddress emailAddress,
    required final Password password,
  });
  void signOut();
  void delete();
  void update(final Account account);
  void resetPassword(final EmailAddress emailAddress);
  AccountDto? getCurrentAccount();
  Stream<AccountDto?> getAccountState();
  Account? findById(final AccountId accountId);
  Account? findByEmailAddress(final EmailAddress emailAddress);
}
