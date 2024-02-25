import '../../../domain/shared/subject.dart';
import '../../shared/session/session.dart';
import 'i_question_recommend_query_service.dart';

class QuestionRecommendUseCase {
  final Session _session;
  final IQuestionRecommendQueryService _queryService;

  QuestionRecommendUseCase({required Session session, required IQuestionRecommendQueryService queryService,}) : _session = session, _queryService = queryService;
  List<> execute(final Subject? subject) {
    final studentId = _session.studentId;
    final recommended = _queryService.getWithMostLikedAnswer(subject, studentId: studentId);
    return recommended;
  }
}
