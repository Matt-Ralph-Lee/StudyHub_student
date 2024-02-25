import 'question_search_dto.dart';

abstract class IQuestionSearchQueryService {
  List<QuestionSearchDto> searchQuestionWithMostLikedAnswer(
      final String searchWord);
}
