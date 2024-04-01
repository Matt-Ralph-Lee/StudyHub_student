import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/question/query_service/search_for_questions_query_service_provider.dart";
import "../../../application/question/application_service/search_for_question_use_case.dart";
import "../../../application/shared/application_service/question_card_dto.dart";

part "serach_questions_controller.g.dart";

@riverpod
class SearchQuestionsController extends _$SearchQuestionsController {
  @override
  Future<List<QuestionCardDto>?> build(String searchTerm) async {
    final queryService = ref.watch(searchForQuestionsQueryServiceDiProvider);
    final searchForTeachersUseCase = SearchForQuestionUseCase(
      queryService: queryService,
    );

    final questionsDetailDto =
        searchForTeachersUseCase.execute(searchWord: '', subject: null);
    return questionsDetailDto;
  }
}
