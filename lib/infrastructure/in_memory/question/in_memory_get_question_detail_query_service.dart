import '../../../application/question/application_service/i_get_question_detail_query_service.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import 'in_memory_question_repository.dart';

class InMemoryGetQuestionDetailQueryService
    implements IGetQuestionDetailQueryService {
  final InMemoryQuestionRepository _repository;

  InMemoryGetQuestionDetailQueryService(this._repository);

  @override
  Future<Question> getByQuestionId(QuestionId questionId) async {
    final question = await _repository.findById(questionId);
    if (question == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.questionNotFound);
    }
    return question;
  }
}
