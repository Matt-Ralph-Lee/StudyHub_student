import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../infrastructure/in_memory/answer/in_memory_answer_repository.dart';
import '../../../../infrastructure/in_memory/answer/in_memory_get_answer_query_service.dart';
import '../../../../infrastructure/in_memory/favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../../../../infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import '../../../answer/application_service/i_get_answer_query_service.dart';
import '../../../shared/flavor/flavor.dart';
import '../../../shared/flavor/flavor_config.dart';
import '../../favorite_teacher/repository/favorite_teacher_repository_provider.dart';
import '../../session/session_provider.dart';
import '../../teacher/teacher_provider.dart';
import '../repository/answer_repository_provider.dart';

part 'answer_query_service_provider.g.dart';

@riverpod
IGetAnswerQueryService getAnswerQueryServiceDi(GetAnswerQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetAnswerQueryService(
          repository: (ref.watch(answerRepositoryDiProvider))
              as InMemoryAnswerRepository,
          teacherRepository: (ref.watch(teacherRepositoryDiProvider))
              as InMemoryTeacherRepository,
          session: ref.watch(nonNullSessionProvider),
          favoriteTeachersRepository:
              (ref.watch(favoriteTeacherRepositoryDiProvider))
                  as InMemoryFavoriteTeachersRepository);
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
