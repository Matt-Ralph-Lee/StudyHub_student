import '../../domain/account/models/account.dart';

class AccountDto {
  final String _emailAddress;
  final String _studentId;

  String get emailAddress => _emailAddress;
  String get studentId => _studentId;

  // AccountDto({
  //   required final String emailAddress,
  //   required final String studentId,
  // })  : _emailAddress = emailAddress,
  //       _studentId = studentId;

  // factory AccountDto.fromAccount(final Account account) {
  //   return AccountDto(
  //     emailAddress: account.emailAddress.value,
  //     studentId: account.studentId.value,
  //   );
  // }

  AccountDto(final Account account)
      : _emailAddress = account.emailAddress.value,
        _studentId = account.studentId.value;
}
