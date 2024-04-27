import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../../../infrastructure/firebase/favorite_teachers/firebase_favorite_teachers_repository.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'favorite_teacher_repository_provider.g.dart';

@riverpod
IFavoriteTeachersRepository favoriteTeacherRepositoryDi(
    FavoriteTeacherRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryFavoriteTeachersRepository();
    case Flavor.stg:
    case Flavor.prd:
      return FirebaseFavoriteTeachersRepository();
  }
}
