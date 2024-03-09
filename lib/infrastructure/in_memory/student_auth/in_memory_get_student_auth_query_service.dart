import '../../../application/student_auth/application_service/i_get_student_auth_query_service.dart';
import '../../../application/student_auth/application_service/student_auth_info_without_password.dart';
import 'in_memory_student_auth_repository.dart';

class InMemoryGetStudentAuthQueryService
    implements IGetStudentAuthQueryService {
  final InMemoryStudentAuthRepository _repository;

  InMemoryGetStudentAuthQueryService(
      {required InMemoryStudentAuthRepository repository})
      : _repository = repository;

  @override
  Stream<StudentAuthInfoWithoutPassword?> userChanges() {
    return _repository.streamController.stream;
  }
}
