import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/firebase/blockings/firebase_blockings_query_service.dart';
import '../../../../infrastructure/firebase/blockings/firebase_blockings_repository.dart';
import '../../../../infrastructure/firebase/teacher/firebase_teacher_repository.dart';
import '../../../../infrastructure/in_memory/blockings/in_memory_blockings_query_service.dart';
import '../../../../infrastructure/in_memory/blockings/in_memory_blockings_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../blockings/application_service/i_get_blockings_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../teacher/teacher_provider.dart';
import '../repository/blockings_repository_provider.dart';

part 'blockings_query_service_provider.g.dart';

@riverpod
IGetBlockingsQueryService getBlockingsQueryServiceDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryBlockingsQueryService(
        repository: (ref.watch(blockingsRepositoryDiProvider))
            as InMemoryBlockingsRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as InMemoryTeacherRepository,
      );
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseBlockingsQueryService(
        repository: (ref.watch(blockingsRepositoryDiProvider))
            as FirebaseBlockingsRepository,
        teacherRepository: (ref.watch(teacherRepositoryDiProvider))
            as FirebaseTeacherRepository,
      );
  }
}
