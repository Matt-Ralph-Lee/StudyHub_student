import '../../../domain/bookmarks/models/bookmarks.dart';
import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';

import '../../shared/session/session.dart';

class BookmarksAddUseCase {
  final Session _session;
  final IBookmarksRepository _repository;

  BookmarksAddUseCase({
    required final Session session,
    required final IBookmarksRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final QuestionId newBookmarkId) async {
    final studentId = _session.studentId;
    var bookmarks = await _repository.getByStudentId(studentId);

    bookmarks ??= Bookmarks(studentId: studentId, questionIdSet: {});

    bookmarks.add(newBookmarkId);

    _repository.save(bookmarks);
  }
}
