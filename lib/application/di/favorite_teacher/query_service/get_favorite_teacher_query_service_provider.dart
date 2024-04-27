import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/firebase/favorite_teachers/firebase_favorite_teacher_query_service.dart';
import '../../../../infrastructure/firebase/favorite_teachers/firebase_favorite_teachers_repository.dart';
import '../../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teacher_query_service.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../teacher/teacher_provider.dart';
import '../repository/favorite_teacher_repository_provider.dart';

part 'get_favorite_teacher_query_service_provider.g.dart';

@riverpod
IGetFavoriteTeacherQueryService getFavoriteTeacherQueryServiceDi(
    GetFavoriteTeacherQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryFavoriteTeacherQueryService(
        repository: (ref.watch(favoriteTeacherRepositoryDiProvider))
            as InMemoryFavoriteTeachersRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseFavoriteTeacherQueryService(
        repository: (ref.watch(favoriteTeacherRepositoryDiProvider))
            as FirebaseFavoriteTeachersRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as FirebaseTeacherRepository,
      );
  }
}
