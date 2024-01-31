import 'i_search_for_teachers_query_service.dart';
import 'search_for_teachers_dto.dart';

class SearchForTeachersUseCase {
  final ISearchForTeachersQueryService _queryService;
  final String _keywordString;

  SearchForTeachersUseCase({
    required final ISearchForTeachersQueryService queryService,
    required final String keywordString,
  })  : _queryService = queryService,
        _keywordString = keywordString;
  List<SearchForTeacherDto>? execute() {
    return _queryService.search(_keywordString);
  }
}
