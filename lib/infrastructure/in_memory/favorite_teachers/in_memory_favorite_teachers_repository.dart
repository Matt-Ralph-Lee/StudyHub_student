import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryFavoriteTeachersRepository
    implements IFavoriteTeachersRepository {
  final store = <StudentId, FavoriteTeachers>{};
  @override
  void save(FavoriteTeachers favoriteTeachers) {
    store[favoriteTeachers.studentId] = favoriteTeachers;
  }

  @override
  FavoriteTeachers? getByStudentId(StudentId studentId) {
    return store[studentId];
  }
}
