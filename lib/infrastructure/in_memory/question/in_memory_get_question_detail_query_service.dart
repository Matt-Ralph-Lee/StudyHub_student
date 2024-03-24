import 'package:studyhub/domain/question/models/question.dart';

import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/infrastructure/in_memory/question/exception/question_infrastructure_exception.dart';
import 'package:studyhub/infrastructure/in_memory/question/exception/question_infrastructure_exception_detail.dart';

import '../../../application/question/application_service/i_get_question_detail_query_service.dart';
import 'in_memory_question_repository.dart';

class InMemoryGetQuestionDetailQueryService
    implements IGetQuestionDetailQueryService {
  final InMemoryQuestionRepository _repository;

  InMemoryGetQuestionDetailQueryService(this._repository);

  @override
  Question getByQuestionId(QuestionId questionId) {
    final question = _repository.findById(questionId);
    if (question == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.questionNotFound);
    }
    return question;
  }
}
