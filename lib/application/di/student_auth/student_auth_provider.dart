import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'student_auth_provider.g.dart';

@riverpod
IStudentAuthRepository studentAuth(StudentAuthRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryStudentAuthRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
