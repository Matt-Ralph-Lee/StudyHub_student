import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_my_questions_query_service.dart';

class GetMyQuestionsUseCase {
  final Session _session;
  final IGetMyQuestionsQueryService _queryService;

  GetMyQuestionsUseCase({
    required final Session session,
    required final IGetMyQuestionsQueryService queryService,
  })  : _session = session,
        _queryService = queryService;
  Future<List<QuestionCardDto>> execute() async {
    final studentId = _session.studentId;
    final found = await _queryService.get(studentId);
    return found;
  }
}
