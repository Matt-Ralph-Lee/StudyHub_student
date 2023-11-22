import '../models/email_address.dart';
import '../models/i_account_repository.dart';

class AccountService {
  final IAccountRepository _repository;

  AccountService({required final IAccountRepository repository})
      : _repository = repository;

  bool exists(final EmailAddress emailAddress) {
    final found = _repository.findByEmailAddress(emailAddress);
    return found != null;
  }
}
