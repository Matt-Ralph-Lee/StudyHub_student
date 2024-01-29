import '../../../domain/teacher/models/teacher_id.dart';
import 'get_teacher_profile_dto.dart';
import 'i_get_teacher_profile_query_service.dart';

class GetTeacherProfileUseCase {
  final TeacherId _teacherId;
  final IGetTeacherProfileQueryService _queryService;

  GetTeacherProfileUseCase({
    required final TeacherId teacherId,
    required final IGetTeacherProfileQueryService queryService,
  })  : _teacherId = teacherId,
        _queryService = queryService;
  GetTeacherProfileDto? execute() {
    return _queryService.findById(_teacherId);
  }
}
