import 'package:studyhub/common/exception/account_exception/account_creation_exception.dart';
import 'package:studyhub/common/exception/account_exception/account_creation_exception_detail.dart';
import 'package:studyhub/common/exception/account_exception/account_process_exception_detail.dart';
import 'package:studyhub/common/exception/account_exception/account_process_exception.dart';
import 'package:studyhub/domain/account_for_student/models/i_account_repository.dart';
import 'package:studyhub/domain/account_for_student/models/email_address.dart';
import 'package:studyhub/domain/account_for_student/models/password.dart';
import 'package:studyhub/domain/account_for_student/services/account_service.dart';

class AccountApplicationService {
  // TODO: エラー捕捉チェック
  final IAccountRepository _repository;
  final AccountService _service;

  AccountApplicationService({
    required final IAccountRepository repository,
    required final AccountService service,
  })  : _repository = repository,
        _service = service;

  Future<void> register(
    final String emailAddressData,
    final String passwordData,
  ) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    if (_service.exists(emailAddress)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    }
    await _repository.create(emailAddress: emailAddress, password: password);
  }

  Future<void> signIn({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    await _repository.signIn(emailAddress: emailAddress, password: password);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }

  Future<void> delete() async {
    await _repository.delete();
    // TODO: 他のリポジトリにあるデータも削除する
  }

  Future<void> resetPassword(final String newPasswordData) async {
    final newPassword = Password(newPasswordData);
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentUser);
    }
    await _repository.resetPassword(account: account, newPassword: newPassword);
  }

  Future<void> changeEmailAddress(final String newemailAddressData) async {
    final newEmailAddress = EmailAddress(newemailAddressData);
    final account = _repository.getCurrentAccount();
    if (account == null) {
      throw const AccountProcessException(
          AccountProcessExceptionDetail.noCurrentUser);
    }
    if (_service.exists(newEmailAddress)) {
      throw const AccountCreationException(
          AccountCreationExceptionDetail.alreadyExists);
    }
    account.changeEmailAddress(newEmailAddress);
    await _repository.savechangedEmailAddress(account);
  }
}
