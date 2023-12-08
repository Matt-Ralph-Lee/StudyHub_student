import '../../domain/student/models/i_student_factory.dart';
import '../../domain/student/models/i_student_repository.dart';
import '../../domain/student_auth/models/i_student_auth_factory.dart';
import '../../domain/student_auth/models/i_student_auth_repository.dart';
import '../../domain/student_auth/service/student_auth_domain_service.dart';

class StudentAuthApplicationService {
  final StudentAuthDomainService _service;
  final IStudentAuthRepository _repository;
  final IStudentAuthFactory _factory;
  final IStudentFactory _studentFactory;
  final IStudentRepository _studentRepository;
  final ISession _session;

  StudentAuthApplicationService({
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
        _studentRepository = studentRepository,
        _session = session;

  Stream<AccountDto?> currentAccountState() {
    return _repository.accountState().map((account) {
      if (account == null) {
        return null;
      }
      return AccountDto.fromAccount(account);
    });
  }
}
