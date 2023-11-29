import '../../common/exception/account/account_creation_exception.dart';
import '../../common/exception/account/account_creation_exception_detail.dart';
import '../../domain/account/models/account_factory.dart';
import '../../domain/account/models/email_address.dart';
import '../../domain/account/models/i_account_repository.dart';
import '../../domain/account/models/password.dart';
import '../../domain/account/service/account_domain_service.dart';
import 'account_dto.dart';

class AccountApplicationService {
  final IAccountRepository _repository;
  final AccountFactory _factory;
  final AccountDomainService _service;

  AccountApplicationService({
    required final IAccountRepository repository,
    required final AccountFactory factory,
    required final AccountDomainService service,
  })  : _repository = repository,
        _factory = factory,
        _service = service;

  void register({
    required final String emailAddressData,
    required final String passwordData,
  }) {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final account = _factory.createwithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(account)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    }
    _repository.save(account);
  }

  void signIn({
    required final String emailAddressData,
    required final String passwordData,
  }) {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    _repository.signIn(emailAddress: emailAddress, password: password);
  }

  void signOut() {
    _repository.signOut();
  }

  void delete() {}

  Stream<AccountDto?> currentAccount() {
    return _repository.getCurrentAccount().map((account) {
      if (account == null) {
        return null;
      }
      return AccountDto(account);
    });
  }
}
