import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryFavoriteTeachersRepository
    implements IFavoriteTeachersRepository {
  late Map<StudentId, FavoriteTeachers> store;
  static final InMemoryFavoriteTeachersRepository _instance =
      InMemoryFavoriteTeachersRepository._internal();

  factory InMemoryFavoriteTeachersRepository() {
    return _instance;
  }

  InMemoryFavoriteTeachersRepository._internal() {
    store = {};
  }

  @override
  Future<void> save(FavoriteTeachers favoriteTeachers) async {
    store[favoriteTeachers.studentId] = favoriteTeachers;
  }

  @override
  Future<FavoriteTeachers?> getByStudentId(StudentId studentId) async {
    return store[studentId];
  }
}
