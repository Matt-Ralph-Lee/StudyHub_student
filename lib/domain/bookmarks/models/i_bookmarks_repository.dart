import 'bookmarks.dart';
import '../../student/models/student_id.dart';

abstract class IBookmarksRepository {
  Future<void> save(final Bookmarks bookmarks);
  Future<Bookmarks?> getByStudentId(final StudentId studentId);
}
