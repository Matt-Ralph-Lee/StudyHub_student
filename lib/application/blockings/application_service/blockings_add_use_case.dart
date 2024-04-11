import '../../../domain/blockings/models/blockings.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../domain/teacher/models/teacher_id.dart';

import '../../shared/session/session.dart';

class BlockingsAddUseCase {
  final Session _session;
  final IBlockingsRepository _repository;

  BlockingsAddUseCase({
    required final Session session,
    required final IBlockingsRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final TeacherId newTeacherId) async {
    final studentId = _session.studentId;
    Blockings? blockings = await _repository.getByStudentId(studentId);

    blockings ??= Blockings(studentId: studentId, teacherIdList: {});

    blockings.add(newTeacherId);

    await _repository.save(blockings);
  }
}
