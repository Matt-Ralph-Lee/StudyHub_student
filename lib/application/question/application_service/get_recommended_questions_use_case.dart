import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_recommended_questions_query_service.dart';

class GetRecommendedQuestionsUseCase {
  final Session _session;
  final IGetRecommendedQuestionsQueryService _queryService;

  GetRecommendedQuestionsUseCase({
    required final Session session,
    required final IGetRecommendedQuestionsQueryService queryService,
  })  : _session = session,
        _queryService = queryService;
  List<QuestionCardDto> execute(final Subject? subject) {
    final studentId = _session.studentId;
    final recommended = _queryService.get(
      subject: subject,
      studentId: studentId,
    );
    return recommended;
  }
}
