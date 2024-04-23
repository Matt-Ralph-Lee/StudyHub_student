import '../../../application/teacher/application_service/i_search_for_teachers_query_service.dart';
import '../../../application/teacher/application_service/search_for_teachers_dto.dart';
import 'in_memory_teacher_repository.dart';

class InMemorySearchForTeachersQueryService
    implements ISearchForTeachersQueryService {
  final InMemoryTeacherRepository _repository;

  InMemorySearchForTeachersQueryService(this._repository);

  @override
  Future<List<SearchForTeacherDto>> search(String keywordString) async {
    final searchForTeacherDtoList = <SearchForTeacherDto>[];

    final result = _repository.store.values
        .where((teacher) => teacher.name.value.contains(keywordString));

    for (final teacher in result) {
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
