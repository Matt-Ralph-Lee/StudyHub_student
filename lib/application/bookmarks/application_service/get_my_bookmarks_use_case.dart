import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_bookmarks_query_service.dart';

class GetMyBookmarksUseCase {
  final Session _session;
  final IGetBookmarksQueryService _queryService;

  GetMyBookmarksUseCase({
    required final Session session,
    required final IGetBookmarksQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  Future<List<QuestionCardDto>> execute() async {
    final studentId = _session.studentId;
    final bookmarks = await _queryService.getByStudentId(studentId);
    return bookmarks;
  }
}
