import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/favorite_teachers_use_case_exception.dart';
import '../exception/favorite_teachers_use_case_exception_detail.dart';

class FavoriteTeachersDeleteUseCase {
  final Session _session;
  final IFavoriteTeachersRepository _repository;
  final ILogger _logger;

  FavoriteTeachersDeleteUseCase({
    required final Session session,
    required final IFavoriteTeachersRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final TeacherId favoriteTeacherId) async {
    _logger.info('BEGIN $FavoriteTeachersDeleteUseCase.execute()');

    final studentId = _session.studentId;
    final favoriteTeachers = await _repository.getByStudentId(studentId);

    if (favoriteTeachers == null) {
      throw const FavoriteTeachersUseCaseException(
          FavoriteTeachersUseCaseExceptionDetail.favoriteTeacherNotFound);
    }

    favoriteTeachers.delete(favoriteTeacherId);

    await _repository.save(favoriteTeachers);

    _logger.info('END $FavoriteTeachersDeleteUseCase.execute()');
  }
}
