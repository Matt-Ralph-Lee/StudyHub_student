import '../../../domain/blockings/models/blockings.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';

class BlockingsAddUseCase {
  final Session _session;
  final IBlockingsRepository _repository;
  final ILogger _logger;

  BlockingsAddUseCase({
    required final Session session,
    required final IBlockingsRepository repository,
    required final ILogger logger,
  })  : _session = session,
        _repository = repository,
        _logger = logger;

  Future<void> execute(final TeacherId newTeacherId) async {
    _logger.info('BEGIN $BlockingsAddUseCase.execute()');

    final studentId = _session.studentId;
    Blockings? blockings = await _repository.getByStudentId(studentId);

    blockings ??= Blockings(studentId: studentId, teacherIdList: {});

    blockings.add(newTeacherId);

    await _repository.save(blockings);

    _logger.info('END $BlockingsAddUseCase.execute()');
  }
}
