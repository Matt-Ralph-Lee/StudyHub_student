import '../../../domain/bookmarks/models/bookmarks.dart';
import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryBookmarksRepository implements IBookmarksRepository {
  late Map<StudentId, Bookmarks> store;
  static final InMemoryBookmarksRepository _instance =
      InMemoryBookmarksRepository._internal();

  factory InMemoryBookmarksRepository() {
    return _instance;
  }

  InMemoryBookmarksRepository._internal() {
    store = {};
  }

  @override
  Future<void> save(Bookmarks bookmarks) async {
    store[bookmarks.studentId] = bookmarks;
  }

  @override
  Future<Bookmarks?> getByStudentId(StudentId studentId) async {
    return store[studentId];
  }

  @override
  Future<bool> checkIsBookmarked(
      {required QuestionId questionId, required StudentId studentId}) async {
    final bookmarkList = store[studentId];
    if (bookmarkList == null) {
      return false;
    }
    return bookmarkList.contains(questionId);
  }
}
