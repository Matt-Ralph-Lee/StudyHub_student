import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studyhub/application/di/liked_answers/repository/liked_answers_repository_provider.dart';

import '../../../../infrastructure/in_memory/liked_answers/in_memory_get_liked_answers_query_service.dart';
import '../../../../infrastructure/in_memory/liked_answers/in_memory_liked_answers_repository.dart';
import '../../../liked_answers/application_service/i_get_liked_answers_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../session/session_provider.dart';

part 'liked_answers_query_service_provider.g.dart';

@riverpod
IGetLikedAnswersQueryService getLikedAnswersQueryServiceDi(
    GetLikedAnswersQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetLikedAnswersQueryService(
        session: ref.watch(nonNullSessionProvider),
        repository: (ref.watch(likedAnswersRepositoryDiProvider))
            as InMemoryLikedAnswersRepository,
      );
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw InMemoryGetLikedAnswersQueryService(
        session: ref.watch(nonNullSessionProvider),
        repository: (ref.watch(likedAnswersRepositoryDiProvider))
            as InMemoryLikedAnswersRepository,
      );
      ;
  }
}
