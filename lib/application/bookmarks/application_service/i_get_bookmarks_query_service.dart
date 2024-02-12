import '../../../domain/student/models/student_id.dart';

import 'get_bookmark_dto.dart';

abstract class IGetBookmarksQueryService {
  List<GetBookmarkDto> getByStudentId(final StudentId studentId);
}
