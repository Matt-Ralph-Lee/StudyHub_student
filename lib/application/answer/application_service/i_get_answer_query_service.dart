import '../../../domain/question/models/question_id.dart';
import 'answer_dto.dart';

abstract class IGetAnswerQueryService {
  List<AnswerDto> getById(final QuestionId questionId);
}
