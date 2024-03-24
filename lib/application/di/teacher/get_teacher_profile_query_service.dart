import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/di/teacher/teacher_provider.dart';

import '../../../infrastructure/in_memory/teacher/in_memory_get_teacher_profile_query_service.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_get_teacher_profile_query_service.dart';

part 'get_teacher_profile_query_service.g.dart';

@riverpod
IGetTeacherProfileQueryService getTeacherProfileQueryServiceDi(
    GetTeacherProfileQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetTeacherProfileQueryService(
        (ref.watch(teacherRepositoryDiProvider)) as InMemoryTeacherRepository,
      );
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
