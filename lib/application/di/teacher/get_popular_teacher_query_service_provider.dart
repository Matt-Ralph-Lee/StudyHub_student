import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/firebase/teacher/firebase_get_popular_teachers_query_service.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_get_popular_teachers_query_service.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_get_popular_teachers_query_service.dart';
import 'teacher_provider.dart';

part 'get_popular_teacher_query_service_provider.g.dart';

@riverpod
IGetPopularTeachersQueryService getPopularTeacherQueryServiceDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetPopularTeachersQueryService(
        (ref.watch(teacherRepositoryDiProvider)) as InMemoryTeacherRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseGetPopularTeachersQueryService();
  }
}
