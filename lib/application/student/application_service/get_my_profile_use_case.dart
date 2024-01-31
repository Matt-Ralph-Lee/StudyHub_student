import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_my_profile_dto.dart';
import 'i_get_my_profile_query_service.dart';

class GetMyProfileUseCase {
  final ISession _session;
  final IGetMyProfileQueryService _queryService;

  GetMyProfileUseCase({
    required final ISession session,
    required final IGetMyProfileQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  GetMyProfileDto execute() {
    final studentId = _session.studentId;
    final myProfile = _queryService.getById(studentId);
    if (myProfile == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.noProfileFound);
    }
    return myProfile;
  }
}
