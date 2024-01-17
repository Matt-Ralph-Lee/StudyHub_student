import '../../../domain/student/models/i_student_repository.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';
import 'get_my_profile_use_case_dto.dart';

class GetMyProfileUseCase {
  final IStudentRepository _repository;
  final ISession _session;

  GetMyProfileUseCase({
    required IStudentRepository repository,
    required ISession session,
  })  : _repository = repository,
        _session = session;

  GetMyProfileUseCaseDto execute() {
    final studentId = _session.studentId;
    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    return GetMyProfileUseCaseDto.fromDomainObject(
      studentName: student.studentName,
      profilePhotoPath: student.profilePhotoPath,
      status: student.status,
      questionCount: student.questionCount,
    );
  }
}
