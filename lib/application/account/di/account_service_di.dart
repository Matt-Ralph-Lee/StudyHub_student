import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/account/di/account_repository_di.dart';
import 'package:studyhub/domain/account/service/account_domain_service.dart';

final accountDomainServiceProvider = Provider<AccountDomainService>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return AccountDomainService(repository);
});
