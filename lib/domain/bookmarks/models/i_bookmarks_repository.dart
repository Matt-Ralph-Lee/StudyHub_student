import 'bookmarks.dart';
import '../../student/models/student_id.dart';

abstract class IBookmarksRepository {
  void save(final Bookmarks bookmarks);
  Bookmarks? findByStudentId(final StudentId studentId);
}
