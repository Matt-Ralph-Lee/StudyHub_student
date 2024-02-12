import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../shared/session/session.dart';
import '../exception/bookmarks_use_case_exception.dart';
import '../exception/bookmarks_use_case_exception_detail.dart';

class BookmarksDeleteUseCase {
  final Session _session;
  final IBookmarksRepository _repository;

  BookmarksDeleteUseCase({
    required final Session session,
    required final IBookmarksRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final QuestionId bookmarkId) async {
    final studentId = _session.studentId;
    final bookmarks = _repository.getByStudentId(studentId);

    if (bookmarks == null) {
      throw const BookmarksUseCaseException(
          BookmarksUseCaseExceptionDetail.bookmarksNotFound);
    }

    bookmarks.delete(bookmarkId);

    _repository.save(bookmarks);
  }
}
