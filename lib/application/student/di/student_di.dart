import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../infrastructure/in_memory/student/in_memory_student_repository.dart';
import '../../common/flavor.dart';
import '../../common/flavor_config.dart';

final studentRepositoryProvider = Provider<IStudentRepository>(
  (ref) {
    switch (flavor) {
      case Flavor.dev:
        return InMemoryStudentRepository();
      // TODO: 各リポジトリの完成に応じて書くこと
      case Flavor.stg:
        return InMemoryStudentRepository();
      case Flavor.prd:
        return InMemoryStudentRepository();
    }
  },
);
