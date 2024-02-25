import '../../shared/application_service/question_card_dto.dart';

abstract class IQuestionSearchQueryService {
  List<QuestionCardDto> searchQuestionWithMostLikedAnswer(
      final String searchWord);
}
