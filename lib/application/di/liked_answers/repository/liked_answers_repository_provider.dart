import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/liked_answer/models/i_liked_answers_repository.dart';
import '../../../../infrastructure/firebase/liked_answers/firebase_liked_answers_repository.dart';
import '../../../../infrastructure/in_memory/liked_answers/in_memory_liked_answers_repository.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';

part 'liked_answers_repository_provider.g.dart';

@riverpod
ILikedAnswersRepository likedAnswersRepositoryDi(
    LikedAnswersRepositoryDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryLikedAnswersRepository();
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw FirebaseLikedAnswersRepository();
  }
}
