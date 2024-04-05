import 'favorite_teachers.dart';
import '../../student/models/student_id.dart';

abstract class IFavoriteTeachersRepository {
  Future<void> save(final FavoriteTeachers favoriteTeachers);
  Future<FavoriteTeachers?> getByStudentId(final StudentId studentId);
}
