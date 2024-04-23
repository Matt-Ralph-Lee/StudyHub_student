import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_my_profile_dto.dart';
import 'i_get_my_profile_query_service.dart';

class GetMyProfileUseCase {
  final Session _session;
  final IGetMyProfileQueryService _queryService;
  final ILogger _logger;

  GetMyProfileUseCase({
    required final Session session,
    required final IGetMyProfileQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<GetMyProfileDto> execute() async {
    _logger.info('BEGIN $GetMyProfileUseCase.execute()');

    final studentId = _session.studentId;
    final myProfile = await _queryService.getById(studentId);
    if (myProfile == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.noProfileFound);
    }

    _logger.info('END $GetMyProfileUseCase.execute()');
    return myProfile;
  }
}
