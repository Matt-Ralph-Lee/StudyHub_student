import 'search_for_teachers_dto.dart';

abstract class ISearchForTeachersQueryService {
  Future<List<SearchForTeacherDto>?> search(final String keywordString);
}
