import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_my_profile_use_case_dto.dart';
import 'i_get_my_profile_query.dart';

class GetMyProfileUseCase {
  final ISession _session;
  final IStudentQueryService _queryService;

  GetMyProfileUseCase({
    required final ISession session,
    required final IStudentQueryService queryService,
  })  : _session = session,
        _queryService = queryService;

  GetMyProfileUseCaseDto execute() {
    final studentId = _session.studentId;
    final myProfile = _queryService.getMyProfileById(studentId);
    if (myProfile == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.noProfileFound);
    }
    return myProfile;
  }
}
