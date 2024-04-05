import '../../../domain/question/models/question_id.dart';
import 'answer_dto.dart';
import 'i_get_answer_query_service.dart';

class GetAnswerUseCase {
  final IGetAnswerQueryService _queryService;

  GetAnswerUseCase(this._queryService);

  Future<List<AnswerDto>> execute(final QuestionId questionId) async {
    final answers = await _queryService.getById(questionId);
    return answers;
  }
}
