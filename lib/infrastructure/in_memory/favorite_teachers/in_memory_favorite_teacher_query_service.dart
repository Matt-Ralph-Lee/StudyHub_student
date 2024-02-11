import '../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart';
import '../../../application/favorite_teachers/application_service/i_get_favorite_teacher_query_service.dart';
import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/teacher/models/teacher.dart';

class InMemoryFavoriteTeacherQueryService
    implements IGetFavoriteTeacherQueryService {
  final store = <StudentId, FavoriteTeachers>{};
  final teacherStore = <TeacherId, Teacher>{};

  @override
  List<GetFavoriteTeacherDto>? getById(StudentId studentId) {
    final favoriteTeacherIds = store[studentId];
    if (favoriteTeacherIds == null) return null;

    List<GetFavoriteTeacherDto> favoriteTeachers = [];

    for (var i = 0; i < favoriteTeacherIds.length; i++) {
      final favoriteTeacher = teacherStore[favoriteTeacherIds[i]];
      if (favoriteTeacher == null) return null;
      favoriteTeachers.add(
        GetFavoriteTeacherDto(
          teacherName: favoriteTeacher.teacherId.value,
          profilePhotoPath: favoriteTeacher.profilePhotoPath.value,
          bio: favoriteTeacher.bio.value,
        ),
      );
    }

    return favoriteTeachers;
  }
}
