import '../../../application/student/application_service/get_my_profile_dto.dart';
import '../../../application/student/application_service/i_get_my_profile_query_service.dart';
import '../../../domain/student/models/student_id.dart';
import 'in_memory_student_repository.dart';

class InMemoryStudentQueryService implements IGetMyProfileQueryService {
  final InMemoryStudentRepository _repository;

  InMemoryStudentQueryService(this._repository);

  @override
  GetMyProfileDto? getById(StudentId studentId) {
    final student = _repository.findById(studentId);
    if (student == null) {
      return null;
    }
    return GetMyProfileDto(
      studentName: student.name.value,
      profilePhotoPath: student.profilePhotoPath.value,
      status: student.status,
      questionCount: student.questionCount.value,
    );
  }
}
