import '../../interfaces/i_logger.dart';
import 'i_search_for_teachers_query_service.dart';
import 'search_for_teachers_dto.dart';

class SearchForTeachersUseCase {
  final ISearchForTeachersQueryService _queryService;
  final ILogger _logger;

  SearchForTeachersUseCase({
    required final ISearchForTeachersQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<List<SearchForTeacherDto>> execute(final String keyWordString) async {
    _logger.info('BEGIN $SearchForTeachersUseCase.execute()');

    final searchForTeacherDtoList = await _queryService.search(keyWordString);

    _logger.info('END $SearchForTeachersUseCase.execute()');
    return searchForTeacherDtoList;
  }
}
