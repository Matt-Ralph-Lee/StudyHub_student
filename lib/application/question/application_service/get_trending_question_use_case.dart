import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';
import 'i_get_trending_question_query_service.dart';

class GetTrendingQuestionUseCase {
  final IGetTrendingQuestionQueryService _queryService;

  GetTrendingQuestionUseCase(this._queryService);

  List<QuestionCardDto> execute(final Subject? subject) {
    final result = _queryService.get(subject);

    return result;
  }
}
