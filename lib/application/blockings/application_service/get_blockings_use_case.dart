import '../../interfaces/i_logger.dart';
import 'get_blocking_dto.dart';
import 'i_get_blockings_query_service.dart';
import '../../shared/session/session.dart';

class GetBlockingsUseCase {
  final Session _session;
  final IGetBlockingsQueryService _queryService;
  final ILogger _logger;

  GetBlockingsUseCase(
      {required final Session session,
      required final IGetBlockingsQueryService queryService,
      required final ILogger logger})
      : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<GetBlockingDto>> execute() async {
    _logger.info('BEGIN $GetBlockingsUseCase.execute()');

    final studentId = _session.studentId;
    final blockings = await _queryService.getByStudentId(studentId);

    _logger.info('END $GetBlockingsUseCase.execute()');
    return blockings;
  }
}
