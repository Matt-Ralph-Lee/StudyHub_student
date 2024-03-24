import '../../../application/teacher/application_service/i_get_popular_teachers_query_service.dart';
import '../../../application/teacher/application_service/search_for_teachers_dto.dart';
import 'in_memory_teacher_repository.dart';

class InMemoryGetPopularTeachersQueryService
    implements IGetPopularTeachersQueryService {
  final InMemoryTeacherRepository _repository;

  InMemoryGetPopularTeachersQueryService(this._repository);

  @override
  List<SearchForTeacherDto>? find() {
    final searchForTeacherDtoList = <SearchForTeacherDto>[];

    final result = _repository.store.values.toList()
      ..sort((a, b) => a.rating.value.compareTo(b.rating.value));

    for (int i = 0; i < 20; i++) {
      //add only 20 popular teacher
      final teacher = result[i];
      searchForTeacherDtoList.add(SearchForTeacherDto(
        teacherId: teacher.teacherId,
        name: teacher.name.value,
        profilePhotoPath: teacher.profilePhotoPath.value,
        bio: teacher.bio.value,
      ));
    }

    return searchForTeacherDtoList;
  }
}
