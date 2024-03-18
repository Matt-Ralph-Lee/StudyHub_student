import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';

class InMemoryQuestionRepository implements IQuestionRepository {
  late Map<QuestionId, Question> store;
  late int _idInt;
  static final InMemoryQuestionRepository _instance =
      InMemoryQuestionRepository._internal();

  factory InMemoryQuestionRepository() {
    return _instance;
  }

  InMemoryQuestionRepository._internal() {
    store = {};
    _idInt = 1000000;
  }

  @override
  void delete(QuestionId questionId) {
    store.remove(questionId);
  }

  @override
  Question? findById(QuestionId questionId) {
    return store[questionId];
  }

  @override
  QuestionId generateId() {
    const idStr = "thisIsATestId";

    String randomId = _idInt.toString() + idStr;

    _idInt++;

    return QuestionId(randomId);
  }

  @override
  void save(Question question) {
    store[question.questionId] = question;
  }
}
