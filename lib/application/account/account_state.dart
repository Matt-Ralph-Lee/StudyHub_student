import "package:riverpod_annotation/riverpod_annotation.dart";

import "account_dto.dart";
import "di/account_application_service_di.dart";
part "account_state.g.dart";

@riverpod
Stream<AccountDto?> currentAccount(CurrentAccountRef ref) {
  final accountApplicationService =
      ref.watch(accountApplicationServiceProvider);
  return accountApplicationService.currentAccount();
}
