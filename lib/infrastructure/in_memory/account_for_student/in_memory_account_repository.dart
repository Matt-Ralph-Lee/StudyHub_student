import '../../../domain/account_for_student/models/account.dart';
import '../../../domain/account_for_student/models/email_address.dart';
import '../../../domain/account_for_student/models/i_account_repository.dart';
import '../../../domain/account_for_student/models/password.dart';

class InMemoryAccountRepository implements IAccountRepository {
  @override
  Stream<Account?> accountStateChanges() {
    // TODO: implement accountStateChanges
    throw UnimplementedError();
  }

  @override
  Account? findByEmailAddress(EmailAddress emailAddress) {
    // TODO: implement findByEmailAddress
    throw UnimplementedError();
  }

  @override
  Future<void> save(Account account) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(
      {required EmailAddress emailAddress, required Password password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
