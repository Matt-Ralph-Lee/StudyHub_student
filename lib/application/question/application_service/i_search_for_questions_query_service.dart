import '../../shared/application_service/question_card_dto.dart';

abstract class ISearchForQuestionsQueryService {
  List<QuestionCardDto> search(final String searchWord);
}
