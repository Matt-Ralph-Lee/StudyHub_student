import '../../../domain/question/models/question_id.dart';
import 'answer_dto.dart';

abstract class IGetAnswerQueryService {
  Future<List<AnswerDto>> getById(final QuestionId questionId);
}
