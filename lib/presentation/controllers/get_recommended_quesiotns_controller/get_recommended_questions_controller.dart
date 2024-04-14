import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/question/query_service/get_recommended_questions_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/question/application_service/get_recommended_questions_use_case.dart";
import "../../../application/shared/application_service/question_card_dto.dart";
import "../../../domain/shared/subject.dart";

part "get_recommended_questions_controller.g.dart";

@riverpod
class GetRecommendedQuestionsController
    extends _$GetRecommendedQuestionsController {
  @override
  Future<List<QuestionCardDto>> build(
    Subject? subject,
  ) async {
    final getRecommendedQuestionsQueryService =
        ref.watch(getRecommendedQuestionQueryServiceDiProvider);
    final session = ref.watch(nonNullSessionProvider);

    final getRecommendedQuestionsUseCase = GetRecommendedQuestionsUseCase(
        session: session, queryService: getRecommendedQuestionsQueryService);

    final getRecommendedQuestionsDto =
        getRecommendedQuestionsUseCase.execute(subject);
    return getRecommendedQuestionsDto;
  }
}
