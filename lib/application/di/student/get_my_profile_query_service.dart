import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/firebase/student/firebase_student_query_service.dart';
import '../../../infrastructure/firebase/student/firebase_student_repository.dart';
import '../../../infrastructure/in_memory/student/in_memory_student_query_service.dart';
import '../../../infrastructure/in_memory/student/in_memory_student_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../student/application_service/i_get_my_profile_query_service.dart';
import 'student_repository_provider.dart';

part 'get_my_profile_query_service.g.dart';

@riverpod
IGetMyProfileQueryService getMyProfileQueryServiceDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetMyProfileQueryService(
          ref.watch(studentRepositoryDiProvider) as InMemoryStudentRepository);
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseStudentQueryService(
          ref.watch(studentRepositoryDiProvider) as FirebaseStudentRepository);
  }
}
