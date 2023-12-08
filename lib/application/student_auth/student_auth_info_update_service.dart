import '../../common/exception/student_auth/student_auth_creation_exception.dart';
import '../../common/exception/student_auth/student_auth_creation_exception_detail.dart';
import '../../common/exception/student_auth/student_auth_process_exception.dart';
import '../../common/exception/student_auth/student_auth_process_exception_detail.dart';
import '../../domain/student_auth/models/email_address.dart';
import '../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../domain/student_auth/models/password.dart';
import '../../domain/student_auth/service/student_auth_domain_service.dart';
import 'i_session.dart';
import 'student_auth_info_update_command.dart';

class StudentUpdateService {
  final IStudentAuthRepository _authRepository;
  final StudentAuthDomainService _service;
  final ISession _session;
  StudentUpdateService({
    required final IStudentAuthRepository authRepository,
    required final StudentAuthDomainService service,
    required final ISession session,
  })  : _authRepository = authRepository,
        _service = service,
        _session = session;

  void execute(StudentAuthInfoUpdateCommand command) {
    final studentId = _session.studentId;
    final studentAuthInfo = _authRepository.findById(studentId);
    if (studentAuthInfo == null) {
      throw const StudentAuthProcessException(
          StudentAuthProcessExceptionDetail.notFound);
    }
    final emailAddressData = command.emailAddress;
    final passwordData = command.password;

    if (emailAddressData != null) {
      final newEmailAddress = EmailAddress(emailAddressData);
      studentAuthInfo.changeEmailAddress(newEmailAddress);
      // TODO: verification 状態が変わることに注意
    }

    if (passwordData != null) {
      final newPassword = Password(passwordData);
      studentAuthInfo.changePassword(newPassword);
    }

    if (_service.exists(studentAuthInfo)) {
      throw const StudentAuthCreationException(
          StudentAuthCreationExceptionDetail.alreadyExists);
    }

    _authRepository.update(studentAuthInfo);
  }
}
