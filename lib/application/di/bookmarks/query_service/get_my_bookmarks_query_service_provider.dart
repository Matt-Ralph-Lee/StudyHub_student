import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/in_memory/bookmarks/in_memory_bookmarks_query_service.dart';
import '../../../../infrastructure/in_memory/bookmarks/in_memory_bookmarks_repository.dart';
import '../../../favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../repository/get_my_bookmarks_repository_provider.dart';

part 'get_my_bookmarks_query_service_provider.g.dart';

@riverpod
IGetMyBookmarksQueryService getMyBookmarksQueryServiceDi(
    GetMyBookmarksQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryBookmarksQueryService(
        repository: ,
        studentRepository: null,
        questionRepository: null,
        teacherRepository: null,
      );
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
