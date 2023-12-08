import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyhub/application/account/account_application_service.dart';
import 'package:studyhub/application/account/di/account_factory_di.dart';
import 'package:studyhub/application/account/di/account_repository_di.dart';
import 'package:studyhub/application/account/di/account_service_di.dart';

final accountApplicationServiceProvider =
    Provider<AccountApplicationService>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  final factory = ref.watch(accountFactoryProvider);
  final service = ref.watch(accountDomainServiceProvider);

  return AccountApplicationService(
      repository: repository, factory: factory, service: service);
});
