import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../shared/session/session.dart';
import '../exception/favorite_teachers_use_case_exception.dart';
import '../exception/favorite_teachers_use_case_exception_detail.dart';

class FavoriteTeachersDeleteUseCase {
  final Session _session;
  final IFavoriteTeachersRepository _repository;

  FavoriteTeachersDeleteUseCase({
    required final Session session,
    required final IFavoriteTeachersRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final TeacherId favoriteTeacherId) async {
    final studentId = _session.studentId;
    final favoriteTeachers = _repository.getByStudentId(studentId);

    if (favoriteTeachers == null) {
      throw const FavoriteTeachersUseCaseException(
          FavoriteTeachersUseCaseExceptionDetail.favoriteTeacherNotFound);
    }

    favoriteTeachers.delete(favoriteTeacherId);

    _repository.save(favoriteTeachers);
  }
}
