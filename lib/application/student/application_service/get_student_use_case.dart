import '../../../domain/student/models/i_student_repository.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_student_dto.dart';

class GetStudentUseCase {
  final IStudentRepository _repository;
  final Session _session;
  final ILogger _logger;

  GetStudentUseCase({
    required final IStudentRepository repository,
    required final Session session,
    required final ILogger logger,
  })  : _repository = repository,
        _session = session,
        _logger = logger;

  Future<GetStudentDto> execute() async {
    _logger.info('BEGIN $GetStudentUseCase.execute()');

    final studentId = _session.studentId;
    final student = await _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    final getStudentDto = GetStudentDto.fromDomainObject(student);

    _logger.info('END $GetStudentUseCase.execute()');
    return getStudentDto;
  }
}
