import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/firebase/favorite_teachers/firebase_favorite_teachers_repository.dart';
import '../../../infrastructure/firebase/teacher/firebase_get_teacher_profile_query_service.dart';
import '../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_get_teacher_profile_query_service.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_get_teacher_profile_query_service.dart';
import '../favorite_teacher/repository/favorite_teacher_repository_provider.dart';
import '../session/session_provider.dart';
import 'teacher_provider.dart';

part 'get_teacher_profile_query_service.g.dart';

@riverpod
IGetTeacherProfileQueryService getTeacherProfileQueryServiceDi(
    GetTeacherProfileQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetTeacherProfileQueryService(
        session: ref.watch(nonNullSessionProvider),
        repository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
        favoriteTeachersRepository:
            (ref.watch(favoriteTeacherRepositoryDiProvider))
                as InMemoryFavoriteTeachersRepository,
      );
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      return FirebaseGetTeacherProfileQueryService(
        session: ref.watch(nonNullSessionProvider),
        repository: (ref.watch(teacherRepositoryDiProvider))
            as FirebaseTeacherRepository,
        favoriteTeacherRepository:
            (ref.watch(favoriteTeacherRepositoryDiProvider))
                as FirebaseFavoriteTeachersRepository,
      );
  }
}
