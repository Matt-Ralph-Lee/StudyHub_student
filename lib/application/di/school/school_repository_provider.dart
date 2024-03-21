import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/domain/school/models/i_school_repository.dart';

import '../../../infrastructure/in_memory/school/in_memory_school_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'school_repository_provider.g.dart';

@riverpod
ISchoolRepository schoolRepositoryDi(SchoolRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemorySchoolRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
