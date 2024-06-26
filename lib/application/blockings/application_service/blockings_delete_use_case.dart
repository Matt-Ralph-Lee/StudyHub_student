import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/blockings_use_case_exception.dart';
import '../exception/blockings_use_case_exception_detail.dart';

class BlockingsDeleteUseCase {
  final Session _session;
  final IBlockingsRepository _repository;
  final ILogger _logger;

  BlockingsDeleteUseCase({
    required final Session session,
    required final IBlockingsRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final TeacherId teacherId) async {
    _logger.info('BEGIN $BlockingsDeleteUseCase.execute()');

    final studentId = _session.studentId;
    final blockings = await _repository.getByStudentId(studentId);

    if (blockings == null) {
      throw const BlockingsUseCaseException(
          BlockingsUseCaseExceptionDetail.blockingsNotFound);
    }

    blockings.delete(teacherId);

    await _repository.save(blockings);

    _logger.info('END $BlockingsDeleteUseCase.execute()');
  }
}
