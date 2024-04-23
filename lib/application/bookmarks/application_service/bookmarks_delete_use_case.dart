import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/bookmarks_use_case_exception.dart';
import '../exception/bookmarks_use_case_exception_detail.dart';

class BookmarksDeleteUseCase {
  final Session _session;
  final IBookmarksRepository _repository;
  final ILogger _logger;

  BookmarksDeleteUseCase({
    required final Session session,
    required final IBookmarksRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final QuestionId bookmarkId) async {
    _logger.info('BEGIN $BookmarksDeleteUseCase.execute()');

    final studentId = _session.studentId;
    final bookmarks = await _repository.getByStudentId(studentId);

    if (bookmarks == null) {
      throw const BookmarksUseCaseException(
          BookmarksUseCaseExceptionDetail.bookmarksNotFound);
    }

    bookmarks.delete(bookmarkId);

    await _repository.save(bookmarks);

    _logger.info('END $BookmarksDeleteUseCase.execute()');
  }
}
