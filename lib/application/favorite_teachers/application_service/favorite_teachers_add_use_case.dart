import '../../../domain/favorite_teachers/models/favorite_teachers.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/favorite_teachers/models/i_favorite_teachers_repository.dart';

import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';

class FavoriteTeachersAddUseCase {
  final Session _session;
  final IFavoriteTeachersRepository _repository;
  final ILogger _logger;

  FavoriteTeachersAddUseCase({
    required final Session session,
    required final IFavoriteTeachersRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final TeacherId newFavoriteTeacherId) async {
    _logger.info('BEGIN $FavoriteTeachersAddUseCase.execute()');

    final studentId = _session.studentId;
    FavoriteTeachers? favoriteTeachers =
        await _repository.getByStudentId(studentId);

    favoriteTeachers ??=
        FavoriteTeachers(studentId: studentId, teacherIdSet: {});

    favoriteTeachers.add(newFavoriteTeacherId);

    await _repository.save(favoriteTeachers);

    _logger.info('END $FavoriteTeachersAddUseCase.execute()');
  }
}
