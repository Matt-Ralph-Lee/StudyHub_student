import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/account_for_student/models/account.dart';
import '../di/account_di.dart';
part 'account_state.g.dart';

@riverpod
Stream<Account?> accountStateChanges(AccountStateChangesRef ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return repository.accountStateChanges();
}

@riverpod
Account? account(AccountRef ref) {
  final accountStateChanges = ref.watch(accountStateChangesProvider);
  return accountStateChanges.when(
    data: (data) => data,
    error: (error, stackTrace) => null, // TODO: error, loadingのときは再考
    loading: () => null,
  );
}

@riverpod
bool signedIn(SignedInRef ref) {
  final account = ref.watch(accountProvider);
  return account != null;
}
