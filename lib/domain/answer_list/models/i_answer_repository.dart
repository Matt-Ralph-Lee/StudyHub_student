import '../../question/models/question_id.dart';
import 'answer.dart';

abstract class IAnswerRepository {
  List<Answer> getByQuestionId(final QuestionId questionId);
}
