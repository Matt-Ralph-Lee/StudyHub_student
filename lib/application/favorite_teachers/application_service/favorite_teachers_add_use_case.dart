import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';

import '../../shared/session/session.dart';

class FavoriteTeachersAddUseCase {
  final Session _session;
  final IFavoriteTeachersRepository _repository;

  FavoriteTeachersAddUseCase({
    required final Session session,
    required final IFavoriteTeachersRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final TeacherId newFavoriteTeacherId) async {
    final studentId = _session.studentId;
    var favoriteTeachers = _repository.findByStudentId(studentId);

    favoriteTeachers ??=
        FavoriteTeachers(studentId: studentId, teacherIdList: []);

    favoriteTeachers.add(newFavoriteTeacherId);

    _repository.save(favoriteTeachers);
  }
}
