import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/question/query_service/get_question_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/question/application_service/get_my_questions_use_case.dart";
import "../../../application/shared/application_service/question_card_dto.dart";

part "get_my_question_controller.g.dart";

@riverpod
class GetMyQuestionController extends _$GetMyQuestionController {
  @override
  Future<List<QuestionCardDto>> build() async {
    final session = ref.watch(sessionDiProvider);
    final queryService = ref.watch(getQuestionQueryServiceDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getMyQuestionsUseCase = GetMyQuestionsUseCase(
      session: session,
      queryService: queryService,
    );

    final questionCardDto = getMyQuestionsUseCase.execute();
    return questionCardDto;
  }
}
