import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/di/favorite_teacher/repository/favorite_teacher_repository_provider.dart';

import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teacher_query_service.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_get_teacher_profile_query_service.dart';
import '../../teacher/teacher_provider.dart';

part 'get_popular_teacher_query_service_provider.g.dart';

@riverpod
IGetTeacherProfileQueryService getPopularTeacherQueryServiceDi(
    GetPopularTeacherQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetPopularTeacherQueryService(
        repository: (ref.watch(favoriteTeacherRepositoryDiProvider))
            as InMemoryFavoriteTeachersRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
      );
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
