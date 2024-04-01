import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/di/teacher/teacher_provider.dart';

import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_search_for_teachers_query_service.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_search_for_teachers_query_service.dart';

part 'search_for_teachers_query_service.g.dart';

@riverpod
ISearchForTeachersQueryService searchForTeachersQueryServiceDi(
    SearchForTeachersQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemorySearchForTeachersQueryService((ref
          .watch(teacherRepositoryDiProvider)) as InMemoryTeacherRepository);
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
