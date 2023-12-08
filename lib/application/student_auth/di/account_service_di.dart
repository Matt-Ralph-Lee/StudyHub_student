import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/account/di/account_repository_di.dart';
import 'package:studyhub/domain/student_auth/service/student_auth_domain_service.dart';

final accountDomainServiceProvider = Provider<StudentAuthDomainService>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return StudentAuthDomainService(repository);
});
