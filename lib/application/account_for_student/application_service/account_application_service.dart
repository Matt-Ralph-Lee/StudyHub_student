import 'package:studyhub/common/exception/account_exception/account_exception_detail.dart';
import 'package:studyhub/common/exception/account_exception/password_exception.dart';
import 'package:studyhub/domain/account_for_student/models/i_account_factory.dart';
import 'package:studyhub/domain/account_for_student/models/i_account_repository.dart';
import 'package:studyhub/domain/account_for_student/models/email_address.dart';
import 'package:studyhub/domain/account_for_student/models/password.dart';
import 'package:studyhub/domain/account_for_student/services/account_service.dart';

class AccountApplicationService {
  final IAccountRepository _repository;
  final IAccountFactory _factory;
  final AccountService _service;

  AccountApplicationService({
    required final IAccountRepository repository,
    required final IAccountFactory factory,
    required final AccountService service,
  })  : _repository = repository,
        _factory = factory,
        _service = service;

  Future<void> register(
    final String emailAddressData,
    final String passwordData,
  ) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final account = await _factory.create(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(account)) {
      throw const AccountException(
          AccountExceptionDetail.alreadyExistException);
    }
    await _repository.save(account);
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

  void resetPassword(final String newPasswordData) {
    final newPassword = Password(newPasswordData);
  }
}
