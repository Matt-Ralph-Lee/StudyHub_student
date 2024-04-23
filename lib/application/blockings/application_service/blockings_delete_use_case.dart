import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../shared/session/session.dart';
import '../exception/blockings_use_case_exception.dart';
import '../exception/blockings_use_case_exception_detail.dart';

class BlockingsDeleteUseCase {
  final Session _session;
  final IBlockingsRepository _repository;

  BlockingsDeleteUseCase({
    required final Session session,
    required final IBlockingsRepository repository,
  })  : _session = session,
        _repository = repository;

  Future<void> execute(final TeacherId teacherId) async {
    final studentId = _session.studentId;
    final blockings = await _repository.getByStudentId(studentId);

    if (blockings == null) {
      throw const BlockingsUseCaseException(
          BlockingsUseCaseExceptionDetail.blockingsNotFound);
    }

    blockings.delete(teacherId);

    await _repository.save(blockings);
  }
}
