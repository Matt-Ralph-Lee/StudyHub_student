import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/school/models/i_school_repository.dart';
import '../../../infrastructure/firebase/school/firebase_school_repository.dart';
import '../../../infrastructure/in_memory/school/in_memory_school_repository.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';

part 'school_repository_provider.g.dart';

@riverpod
ISchoolRepository schoolRepositoryDi(Ref ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemorySchoolRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseSchoolRepository();
  }
}
