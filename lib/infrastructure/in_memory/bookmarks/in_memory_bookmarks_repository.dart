import '../../../domain/bookmarks/models/bookmarks.dart';
import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryBookmarksRepository implements IBookmarksRepository {
  final store = <StudentId, Bookmarks>{};
  @override
  void save(Bookmarks bookmarks) {
    store[bookmarks.studentId] = bookmarks;
  }

  @override
  Bookmarks? findByStudentId(StudentId studentId) {
    return store[studentId];
  }
}
