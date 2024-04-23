import 'package:studyhub/application/student/exception/student_use_case_exception.dart';
import 'package:studyhub/application/student/exception/student_use_case_exception_detail.dart';
import 'package:studyhub/domain/student/models/i_student_repository.dart';

import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../interfaces/i_logger.dart';
import 'update_student_auth_info_command.dart';

class UpdateStudentAuthInfoUseCase {
  final IStudentAuthRepository _repository;
  final IStudentRepository _studentRepository;
  final ILogger _logger;

  UpdateStudentAuthInfoUseCase({
    required final IStudentAuthRepository repository,
    required final IStudentRepository studentRepository,
    required final ILogger logger,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _logger = logger;

  Future<void> execute(final UpdateStudentAuthInfoCommand command) async {
    _logger.info('BEGIN $UpdateStudentAuthInfoUseCase.execute()');

    final emailAddressData = command.emailAddress;
    final emailAddressToResetPassword = command.emailAddressToResetPassword;

    if (emailAddressData != null) {
      final newEmailAddress = EmailAddress(emailAddressData);
      final studentId = _repository.getStudentIdSnapshot();
      if (studentId == null) {
        throw const StudentUseCaseException(
            StudentUseCaseExceptionDetail.notSignedIn);
      }

      await _repository.updateEmailAddress(newEmailAddress);
      await _studentRepository.updateEmailAddress(
          studentId: studentId, newEmailAddress: newEmailAddress);
    }

    if (emailAddressToResetPassword != null) {
      final emailAddress = EmailAddress(emailAddressToResetPassword);
      await _repository.sendPasswordResetEmail(emailAddress: emailAddress);
    }

    _logger.info('END $UpdateStudentAuthInfoUseCase.execute()');
  }
}
