import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/service/student_auth_domain_service.dart';
import '../../shared/session/session.dart';
import '../exception/student_auth_use_case_exception.dart';
import '../exception/student_auth_use_case_exception_detail.dart';

class EmailAddressUpdateUseCase {
  final IStudentAuthRepository _authRepository;
  final StudentAuthDomainService _service;
  final Session _session;
  EmailAddressUpdateUseCase({
    required final IStudentAuthRepository authRepository,
    required final StudentAuthDomainService service,
    required final Session session,
  })  : _authRepository = authRepository,
        _service = service,
        _session = session;

  void execute(final String emailAddressData) {
    final studentId = _session.studentId;
    final studentAuthInfo = _authRepository.findById(studentId);
    if (studentAuthInfo == null) {
      throw const StudentAuthUseCaseException(
          StudentAuthUseCaseExceptionDetail.notFound);
    }

    final newEmailAddress = EmailAddress(emailAddressData);
    studentAuthInfo.changeEmailAddress(newEmailAddress);

    if (_service.exists(studentAuthInfo)) {
      throw const StudentAuthUseCaseException(
          StudentAuthUseCaseExceptionDetail.alreadyExists);
    }

    _authRepository.updateEmailAddress(studentAuthInfo);
  }
}
