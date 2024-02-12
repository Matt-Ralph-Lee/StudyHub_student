import 'i_get_bookmarks_query_service.dart';
import 'get_bookmarks_dto.dart';

import '../../shared/session/session.dart';

class GetFavoriteTeacherUseCase {
  final Session _session;
  final IGetBookmarksQueryService _queryService;

  GetFavoriteTeacherUseCase({
    required final Session session,
    required final IGetBookmarksQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  List<GetBookmarksDto>? execute() {
    final studentId = _session.studentId;
    final bookmarks = _queryService.getByStudentId(studentId);
    return bookmarks;
  }
}
