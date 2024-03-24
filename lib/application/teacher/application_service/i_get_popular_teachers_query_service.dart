import 'search_for_teachers_dto.dart';

abstract class IGetPopularTeachersQueryService {
  List<SearchForTeacherDto>? find();
}
