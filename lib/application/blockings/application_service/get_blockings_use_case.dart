import 'get_blocking_dto.dart';
import 'i_get_blockings_query_service.dart';
import '../../shared/session/session.dart';

class GetBlockingsUseCase {
  final Session _session;
  final IGetBlockingsQueryService _queryService;

  GetBlockingsUseCase({
    required final Session session,
    required final IGetBlockingsQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  List<GetBlockingDto>? execute() {
    final studentId = _session.studentId;
    final blockings = _queryService.getByStudentId(studentId);
    return blockings;
  }
}
