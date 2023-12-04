import '../models/account.dart';
import '../models/i_account_repository.dart';

class AccountDomainService {
  final IAccountRepository _repository;

  AccountDomainService(final IAccountRepository repository)
      : _repository = repository;

  bool exists(final Account account) {
    final found = _repository.findByEmailAddress(account.emailAddress);
    return found != null;
  }

  void verify(final Account account) {
    _repository.verify(account.emailAddress);
  }
}
