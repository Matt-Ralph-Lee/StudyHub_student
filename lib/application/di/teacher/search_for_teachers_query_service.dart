import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../infrastructure/firebase/teacher/firebase_search_for_teachers_query_service.dart';
import '../../../infrastructure/in_memory/teacher/in_memory_search_for_teachers_query_service.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../../teacher/application_service/i_search_for_teachers_query_service.dart';
import 'teacher_provider.dart';

part 'search_for_teachers_query_service.g.dart';

@riverpod
ISearchForTeachersQueryService searchForTeachersQueryServiceDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemorySearchForTeachersQueryService((ref
          .watch(teacherRepositoryDiProvider)) as InMemoryTeacherRepository);
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseSearchForTeachersQueryService();
  }
}
