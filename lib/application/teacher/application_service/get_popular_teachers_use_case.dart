import '../../interfaces/i_logger.dart';
import 'i_get_popular_teachers_query_service.dart';
import 'search_for_teachers_dto.dart';

class GetPopularTeachersUseCase {
  final IGetPopularTeachersQueryService _queryService;
  final ILogger _logger;

  GetPopularTeachersUseCase(
      {required final IGetPopularTeachersQueryService queryService,
      required final ILogger logger})
      : _queryService = queryService,
        _logger = logger;

  Future<List<SearchForTeacherDto>> execute() async {
    _logger.info('BEGIN $GetPopularTeachersUseCase.execute()');

    final searchForTeacherDtoList = await _queryService.find();

    _logger.info('END $GetPopularTeachersUseCase.execute()');
    return searchForTeacherDtoList;
  }
}
