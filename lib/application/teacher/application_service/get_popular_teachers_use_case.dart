import 'i_get_popular_teachers_query_service.dart';
import 'search_for_teachers_dto.dart';

class GetPopularTeachersUseCase {
  final IGetPopularTeachersQueryService _queryService;

  GetPopularTeachersUseCase(this._queryService);
  Future<List<SearchForTeacherDto>?> execute() async {
    return await _queryService.find();
  }
}
