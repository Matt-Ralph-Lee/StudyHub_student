import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../../infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'photo_repository_provider.g.dart';

@riverpod
IPhotoRepository photoRepositoryDi(PhotoRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryPhotoRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
