import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../infrastructure/in_memory/question/in_memory_get_question_detail_query_service.dart';
import '../../../infrastructure/in_memory/question/in_memory_question_repository.dart';
import '../../question/application_service/i_get_question_detail_query_service.dart';
import '../../shared/flavor/flavor.dart';
import '../../shared/flavor/flavor_config.dart';
import '../question/repository/question_repository_provider.dart';

part 'question_detail_query_service_provider.g.dart';

@riverpod
IGetQuestionDetailQueryService getQuestionDetailQueryServiceDi(
    GetQuestionDetailQueryServiceDiRef ref) {
  switch (flavor) {
    case Flavor.dev:
      return InMemoryGetQuestionDetailQueryService(ref
          .watch(questionRepositoryDiProvider) as InMemoryQuestionRepository);
    case Flavor.stg:
      throw UnimplementedError();
    case Flavor.prd:
      throw UnimplementedError();
  }
}
