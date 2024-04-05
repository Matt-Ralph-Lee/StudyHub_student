import '../favorite_teachers/in_memory_favorite_teachers_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';

import '../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart';
import '../../../application/favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/favorite_teachers/models/favorite_teachers.dart';

class InMemoryFavoriteTeacherQueryService
    implements IGetFavoriteTeacherQueryService {
  final InMemoryFavoriteTeachersRepository _repository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemoryFavoriteTeacherQueryService({
    required final InMemoryFavoriteTeachersRepository repository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<GetFavoriteTeacherDto>> getById(StudentId studentId) async {
    final favoriteTeacherIds = await _repository.getByStudentId(studentId);
    if (favoriteTeacherIds == null) {
      _repository.save(
        FavoriteTeachers(
          studentId: studentId,
          teacherIdSet: {},
        ),
      );
      return [];
    }

    List<GetFavoriteTeacherDto> favoriteTeachers = [];

    for (final TeacherId favoriteTeacherId in favoriteTeacherIds) {
      final favoriteTeacher =
          await _teacherRepository.getByTeacherId(favoriteTeacherId);
      if (favoriteTeacher == null) continue;
      favoriteTeachers.add(
        GetFavoriteTeacherDto(
          teacherId: favoriteTeacher.teacherId,
          teacherName: favoriteTeacher.teacherId.value,
          profilePhotoPath: favoriteTeacher.profilePhotoPath.value,
          bio: favoriteTeacher.bio.value,
        ),
      );
    }

    return favoriteTeachers;
  }
}
