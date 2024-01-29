import '../../../domain/student/models/i_student_repository.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_student_dto.dart';

class GetStudentUseCase {
  final IStudentRepository _repository;
  final ISession _session;

  GetStudentUseCase(
      {required IStudentRepository repository, required ISession session})
      : _repository = repository,
        _session = session;

  GetStudentDto execute() {
    final studentId = _session.studentId;
    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    return GetStudentDto.fromDomainObject(student);
  }
}
