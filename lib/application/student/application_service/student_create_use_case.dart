import '../../../domain/student/models/i_student_factory.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student_auth/models/email_address.dart';
import '../../../domain/student_auth/models/i_student_auth_factory.dart';
import '../../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/student_auth/service/student_auth_domain_service.dart';
import '../../shared/session/i_session.dart';
import '../../student_auth/exception/student_auth_use_case_exception.dart';
import '../../student_auth/exception/student_auth_use_case_exception_detail.dart';

class StudentCreateUseCase {
  final StudentAuthDomainService _service;
  final IStudentAuthRepository _repository;
  final IStudentAuthFactory _factory;
  final IStudentFactory _studentFactory;
  final IStudentRepository _studentRepository;

  StudentCreateUseCase({
    required final StudentAuthDomainService service,
    required final IStudentAuthRepository repository,
    required final IStudentAuthFactory factory,
    required final IStudentFactory studentFactory,
    required final IStudentRepository studentRepository,
    required final ISession session,
  })  : _factory = factory,
        _repository = repository,
        _service = service,
        _studentFactory = studentFactory,
        _studentRepository = studentRepository;

  void execute({
    required final String emailAddressData,
    required final String passwordData,
  }) async {
    final emailAddress = EmailAddress(emailAddressData);
    final password = Password(passwordData);
    final studentAuthInfo = await _factory.createWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (_service.exists(studentAuthInfo)) {
      throw const StudentAuthUseCaseException(
          StudentAuthUseCaseExceptionDetail.alreadyExists);
    }
    _repository.create(studentAuthInfo);
    _service.requireVerification(studentAuthInfo);
    final student = _studentFactory.createInitially(studentAuthInfo.studentId);
    _studentRepository.save(student);
  }
}
