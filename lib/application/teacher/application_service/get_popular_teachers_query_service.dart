import 'search_for_teachers_dto.dart';

abstract class GetPopularTeachersQueryService {
  List<SearchForTeacherDto>? find();
}
