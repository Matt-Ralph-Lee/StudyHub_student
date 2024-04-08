import 'get_favorite_teacher_dto.dart';

import '../../../application/favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../shared/session/session.dart';

class GetFavoriteTeacherUseCase {
  final Session _session;
  final IGetFavoriteTeacherQueryService _queryService;

  GetFavoriteTeacherUseCase({
    required final Session session,
    required final IGetFavoriteTeacherQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  Future<List<GetFavoriteTeacherDto>> execute() async {
    final studentId = _session.studentId;
    final favoriteTeachers = await _queryService.getById(studentId);
    return favoriteTeachers;
  }
}
