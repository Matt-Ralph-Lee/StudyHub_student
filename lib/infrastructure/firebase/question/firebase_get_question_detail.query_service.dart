import '../../../application/question/application_service/i_get_question_detail_query_service.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import 'firebase_question_repository.dart';

class FirebaseGetQuestionDetailQueryService
    implements IGetQuestionDetailQueryService {
  final FirebaseQuestionRepository _repository;

  FirebaseGetQuestionDetailQueryService(this._repository);

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
