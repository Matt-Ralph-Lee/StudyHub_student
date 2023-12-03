import '../../domain/account/models/account.dart';

class AccountDto {
  final String _emailAddress;
  final String _accountId;

  String get emailAddress => _emailAddress;
  String get accountId => _accountId;

  AccountDto({
    required final String emailAddress,
    required final String accountId,
  })  : _emailAddress = emailAddress,
        _accountId = accountId;

  factory AccountDto.fromAccount(final Account account) {
    return AccountDto(
      emailAddress: account.emailAddress.value,
      accountId: account.accountId.value,
    );
  }

  // AccountDto(final Account account)
  //     : _emailAddress = account.emailAddress.value,
  //       _studentId = account.studentId.value;
}
