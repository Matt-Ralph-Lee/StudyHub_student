import '../../interfaces/i_logger.dart';
import 'get_favorite_teacher_dto.dart';

import '../../../application/favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../shared/session/session.dart';

class GetFavoriteTeacherUseCase {
  final Session _session;
  final IGetFavoriteTeacherQueryService _queryService;
  final ILogger _logger;

  GetFavoriteTeacherUseCase({
    required final Session session,
    required final IGetFavoriteTeacherQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<GetFavoriteTeacherDto>> execute() async {
    _logger.info('BEGIN $GetFavoriteTeacherUseCase.execute()');

    final studentId = _session.studentId;
    final favoriteTeachers = await _queryService.getById(studentId);

    _logger.info('END $GetFavoriteTeacherUseCase.execute()');
    return favoriteTeachers;
  }
}
