import 'search_for_teachers_dto.dart';

abstract class ISearchForTeachersQueryService {
  List<SearchForTeacherDto>? search(final String keywordString);
}
