import '../../../domain/student/service/student_service.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../interfaces/i_logger.dart';
import '../../student/exception/student_use_case_exception.dart';
import '../../student/exception/student_use_case_exception_detail.dart';

class SignInUseCase {
  final IStudentAuthRepository _repository;
  final StudentService _service;
  final ILogger _logger;

  SignInUseCase({
    required final IStudentAuthRepository repository,
    required final StudentService service,
    required final ILogger logger,
  })  : _repository = repository,
        _service = service,
        _logger = logger;

  Future<void> execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    _logger.info('BEGIN $SignInUseCase.execute()');

    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);

    final isStudent = await _service.isStudent(emailAddress);
    if (!isStudent) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    await _repository.signIn(emailAddress: emailAddress, password: password);

    await _repository.registerToken(
        emailAddress: emailAddress, studentId: null);

    _logger.info('END $SignInUseCase.execute()');
  }
}
