import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/question/application_service/get_my_questions_use_case.dart";
import "../../../application/shared/application_service/question_card_dto.dart";

part "question_controller.g.dart";

@riverpod
class QuestionController extends _$QuestionController {
  @override
  Future<List<QuestionCardDto>> build() async {
    final session = ref.watch(sessionDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getMyQuestionsUseCase = GetMyQuestionsUseCase(
      session: session,
      queryService: null,
    );

    final questionCardDto = getMyQuestionsUseCase.execute();
    return questionCardDto;
  }
}
