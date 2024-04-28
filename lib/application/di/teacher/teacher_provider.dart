import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/teacher/models/i_teacher_repository.dart';
import '../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'teacher_provider.g.dart';

@riverpod
ITeacherRepository teacherRepositoryDi(TeacherRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryTeacherRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseTeacherRepository();
  }
}
