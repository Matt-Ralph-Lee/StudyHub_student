import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_question_recommend_query_service.dart';

class GetRecommendedQuestionsUseCase {
  final Session _session;
  final IQuestionRecommendQueryService _queryService;

  GetRecommendedQuestionsUseCase({
    required final Session session,
    required final IQuestionRecommendQueryService queryService,
  })  : _session = session,
        _queryService = queryService;
  List<QuestionCardDto> execute(final Subject? subject) {
    final studentId = _session.studentId;
    final recommended = _queryService.getWithMostLikedAnswer(
      subject: subject,
      studentId: studentId,
    );
    return recommended;
  }
}
