import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/account/di/account_repository_di.dart';
import 'package:studyhub/domain/account/models/account_factory.dart';

final accountFactoryProvider = Provider<AccountFactory>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return AccountFactory(repository);
});
