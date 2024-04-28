import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../../infrastructure/firebase/blockings/firebase_blockings_repository.dart';
import '../../../../infrastructure/in_memory/blockings/in_memory_blockings_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'blockings_repository_provider.g.dart';

@riverpod
IBlockingsRepository blockingsRepositoryDi(BlockingsRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryBlockingsRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseBlockingsRepository();
  }
}
