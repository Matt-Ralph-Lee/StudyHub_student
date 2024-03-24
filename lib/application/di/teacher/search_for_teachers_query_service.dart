import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/di/favorite_teacher/repository/favorite_teacher_repository_provider.dart';
import 'package:studyhub/application/teacher/application_service/i_search_for_teachers_query_service.dart';

import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teacher_query_service.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'search_for_teachers_query_service.g.dart';

@riverpod
ISearchForTeachersQueryService searchForTeachersQueryServiceDi(
    SearchForTeachersQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemorySearchForTeachersQueryService(); //未実装なので石橋くんorマシューに実装してもらう
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
