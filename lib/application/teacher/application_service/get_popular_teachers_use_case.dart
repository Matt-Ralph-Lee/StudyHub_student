import 'i_get_popular_teachers_query_service.dart';
import 'search_for_teachers_dto.dart';

class GetPopularTeachersUseCase {
  final IGetPopularTeachersQueryService _queryService;

  GetPopularTeachersUseCase(this._queryService);
  List<SearchForTeacherDto>? execute() {
    return _queryService.find();
  }
}
