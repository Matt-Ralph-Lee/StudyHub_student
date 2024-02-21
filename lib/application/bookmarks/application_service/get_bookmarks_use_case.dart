import 'i_get_bookmarks_query_service.dart';
import 'get_bookmark_dto.dart';

import '../../shared/session/session.dart';

class GetBookmarksUseCase {
  final Session _session;
  final IGetBookmarksQueryService _queryService;

  GetBookmarksUseCase({
    required final Session session,
    required final IGetBookmarksQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  List<GetBookmarkDto>? execute() {
    final studentId = _session.studentId;
    final bookmarks = _queryService.getByStudentId(studentId);
    return bookmarks;
  }
}
