import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';
import 'i_get_liked_answers_query_service.dart';
import 'liked_answers_dto.dart';

class GetLikedAnswersUseCase {
  final IGetLikedAnswersQueryService _queryService;
  final ILogger _logger;

  GetLikedAnswersUseCase({
    required final IGetLikedAnswersQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<LikedAnswersDto> execute(final StudentId studentId) async {
    _logger.info('BEGIN $GetLikedAnswersUseCase.execute()');

    final answers = await _queryService.getByStudentId(studentId);

    _logger.info('END $GetLikedAnswersUseCase.execute()');
    return answers;
  }
}
