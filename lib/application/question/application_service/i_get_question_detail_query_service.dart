import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';

abstract class IGetQuestionDetailQueryService {
  Question getByQuestionId(final QuestionId questionId);
}
