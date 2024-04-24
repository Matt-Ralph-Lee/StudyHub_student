import '../../../domain/bookmarks/models/bookmarks.dart';
import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';

class BookmarksAddUseCase {
  final Session _session;
  final IBookmarksRepository _repository;
  final ILogger _logger;

  BookmarksAddUseCase({
    required final Session session,
    required final IBookmarksRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final QuestionId newBookmarkId) async {
    _logger.info('BEGIN $BookmarksAddUseCase.execute()');

    final studentId = _session.studentId;
    Bookmarks? bookmarks = await _repository.getByStudentId(studentId);

    bookmarks ??= Bookmarks(studentId: studentId, questionIdSet: {});

    bookmarks.add(newBookmarkId);

    await _repository.save(bookmarks);

    _logger.info('END $BookmarksAddUseCase.execute()');
  }
}
