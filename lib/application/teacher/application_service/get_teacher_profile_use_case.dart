import '../../../domain/teacher/models/teacher_id.dart';
import '../../interfaces/i_logger.dart';
import 'get_teacher_profile_dto.dart';
import 'i_get_teacher_profile_query_service.dart';

class GetTeacherProfileUseCase {
  final IGetTeacherProfileQueryService _queryService;
  final ILogger _logger;

  GetTeacherProfileUseCase({
    required final IGetTeacherProfileQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<GetTeacherProfileDto?> execute(final TeacherId teacherId) async {
    _logger.info('BEGIN $GetTeacherProfileUseCase.execute()');

    final getTeacherProfileDto = await _queryService.findById(teacherId);

    _logger.info('END $GetTeacherProfileUseCase.execute()');
    return getTeacherProfileDto;
  }
}
