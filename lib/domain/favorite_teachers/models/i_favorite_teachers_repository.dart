import 'favorite_teachers.dart';
import '../../student/models/student_id.dart';

abstract class IFavoriteTeachersRepository {
  void save(final FavoriteTeachers favoriteTeachers);
  FavoriteTeachers? getByStudentId(final StudentId studentId);
}
