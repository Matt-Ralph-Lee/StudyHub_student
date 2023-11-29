import '../models/account.dart';
import '../models/i_account_repository.dart';

class AccountDomainService {
  final IAccountRepository _repository;

  AccountDomainService(final IAccountRepository repository)
      : _repository = repository;

  bool exists(final Account account) {
    return _repository.emailAddressExists(account.emailAddress);
  }
}
