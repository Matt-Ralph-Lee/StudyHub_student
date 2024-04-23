import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';

abstract class IGetQuestionDetailQueryService {
  Future<Question> getByQuestionId(final QuestionId questionId);
}
