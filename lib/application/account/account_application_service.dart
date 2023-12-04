import '../../common/exception/account/account_creation_exception.dart';
import '../../common/exception/account/account_creation_exception_detail.dart';
import '../../common/exception/account/account_process_exception.dart';
import '../../common/exception/account/account_process_exception_detail.dart';
import '../../domain/account/models/email_address.dart';
import '../../domain/account/models/i_account_factory.dart';
import '../../domain/account/models/i_account_repository.dart';
import '../../domain/account/models/password.dart';
import '../../domain/account/service/account_domain_service.dart';
import 'account_dto.dart';
import 'account_update_command.dart';

class AccountApplicationService {
  final AccountDomainService _service;
  final IAccountRepository _repository;
  final IAccountFactory _factory;

  AccountApplicationService({
    required final AccountDomainService service,
    required final IAccountRepository repository,
    required final IAccountFactory factory,
  })  : _factory = factory,
        _repository = repository,
        _service = service;

  void create({
    required final String emailAddressData,
    required final String passwordData,
  }) {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final account = _factory.createWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(account)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    }
    _repository.create(account);
    _service.verify(account);
    // TODO: Studentのcreateも整合性保守のため同時に行う
  }

  void signIn({
    required final String emailAddressData,
    required final String passwordData,
  }) {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    _repository.signIn(emailAddress: emailAddress, password: password);
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentAccount);
    }
    if (account.isVerified == false) {
      _service.verify(account);
    }
  }

  void signOut() {
    final currentAccount = _repository.getCurrentAccount();
    if (currentAccount == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentAccount);
    }
    // TODO:引数などについてはインメモリリポジトリとの兼ね合いも含め再考
    _repository.signOut();
  }

  void delete() {
    final currentAccount = _repository.getCurrentAccount();
    if (currentAccount == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentAccount);
    }
    // TODO:引数などについてはインメモリリポジトリとの兼ね合いも含め再考
    _repository.delete();
  }

  void update(AccountUpdateCommand command) {
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentAccount);
    }

    final emailAddressData = command.emailAddress;
    final passwordData = command.password;

    if (emailAddressData != null) {
      final newEmailAddress = EmailAddress(emailAddressData);
      account.changeEmailAddress(newEmailAddress);
    }

    if (passwordData != null) {
      final newPassword = Password(passwordData);
      account.changePassword(newPassword);
    }

    if (_service.exists(account)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    }

    _repository.update(account);
  }

  void resetPassword(final String emailAddressData) {
    final emailAddress = EmailAddress(emailAddressData);
    _repository.resetPassword(emailAddress);
  }

  Stream<AccountDto?> currentAccountState() {
    return _repository.accountState().map((account) {
      if (account == null) {
        return null;
      }
      return AccountDto.fromAccount(account);
    });
  }
}