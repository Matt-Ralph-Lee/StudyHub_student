import '../models/account.dart';
import '../models/i_account_repository.dart';

class AccountService {
  final IAccountRepository _repository;

  AccountService({required final IAccountRepository repository})
      : _repository = repository;

  bool exists(final Account account) {
    final emailAddress = account.emailAddress;
    final found = _repository.findByEmailAddress(emailAddress);
    return found != null;
  }
}
