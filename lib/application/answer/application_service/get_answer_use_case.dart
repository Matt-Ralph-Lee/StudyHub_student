import '../../../domain/question/models/question_id.dart';
import 'answer_dto.dart';
import 'i_get_answer_query_service.dart';

class GetAnswerUseCase {
  final IGetAnswerQueryService _queryService;

  GetAnswerUseCase(this._queryService);

  List<AnswerDto> execute(final QuestionId questionId) {
    final answers = _queryService.getById(questionId);
    return answers;
  }
}
