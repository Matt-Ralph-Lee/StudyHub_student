import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../infrastructure/in_memory/student_auth/in_memory_student_auth_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

final studentAuthProvider = Provider<IStudentAuthRepository>((ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryStudentAuthRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
});
