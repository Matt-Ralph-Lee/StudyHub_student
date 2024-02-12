import '../../../domain/student/models/student_id.dart';

import 'get_bookmarks_dto.dart';

abstract class IGetBookmarksQueryService {
  List<GetBookmarksDto>? getByStudentId(final StudentId studentId);
}
