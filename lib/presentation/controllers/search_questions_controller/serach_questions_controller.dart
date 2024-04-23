import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/question/query_service/search_for_questions_query_service_provider.dart";
import "../../../application/question/application_service/search_for_question_use_case.dart";
import "../../../application/shared/application_service/question_card_dto.dart";
import "../../../domain/shared/subject.dart";

part "serach_questions_controller.g.dart";

@riverpod
class SearchQuestionsController extends _$SearchQuestionsController {
  @override
  Future<List<QuestionCardDto>?> build(
      final String searchTerm, final Subject? subject) async {
    final queryService = ref.watch(searchForQuestionsQueryServiceDiProvider);
    final logger = ref.read(loggerDiProvider);
    final searchForTeachersUseCase = SearchForQuestionUseCase(
      queryService: queryService,
      logger: logger,
    );

    final questionsDetailDto = searchForTeachersUseCase.execute(
        searchWord: searchTerm, subject: subject);
    return questionsDetailDto;
  }
}
