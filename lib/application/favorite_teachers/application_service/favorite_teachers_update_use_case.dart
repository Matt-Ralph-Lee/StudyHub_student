import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/favorite_teachers/models/favorite_teachers.dart';
import 'package:studyhub/domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

class FavoriteTeachersUpdateUseCase {
  final Session _session;
  final IFavoriteTeachersRepository _repository;

  FavoriteTeachersUpdateUseCase({
    required final Session session,
    required final IFavoriteTeachersRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final List<String> favoriteTeachersListData) async {
    final studentId = _session.studentId;
    List<TeacherId> favoriteTeachersList = [];

    for (final favoriteTeacherData in favoriteTeachersListData) {
      favoriteTeachersList.add(TeacherId(favoriteTeacherData));
    }

    _repository.save(FavoriteTeachers(
      studentId: studentId,
      teacherIdList: favoriteTeachersList,
    ));
  }
}
