import '../../interfaces/i_logger.dart';
import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_bookmarks_query_service.dart';

class GetMyBookmarksUseCase {
  final Session _session;
  final IGetBookmarksQueryService _queryService;
  final ILogger _logger;

  GetMyBookmarksUseCase({
    required final Session session,
    required final IGetBookmarksQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<QuestionCardDto>> execute() async {
    _logger.info('BEGIN $GetMyBookmarksUseCase.execute()');

    final studentId = _session.studentId;
    final bookmarks = await _queryService.getByStudentId(studentId);

    _logger.info('END $GetMyBookmarksUseCase.execute()');
    return bookmarks;
  }
}
