import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../infrastructure/firebase/student/firebase_student_repository.dart';
import '../../../infrastructure/in_memory/student/in_memory_student_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'student_repository_provider.g.dart';

@riverpod
IStudentRepository studentRepositoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryStudentRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseStudentRepository();
  }
}
