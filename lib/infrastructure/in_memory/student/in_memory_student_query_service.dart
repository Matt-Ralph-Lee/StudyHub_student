import '../../../application/student/application_service/get_my_profile_use_case_dto.dart';
import '../../../application/student/application_service/i_get_my_profile_query.dart';
import '../../../domain/student/models/student_id.dart';
import 'in_memory_student_repository.dart';

class InMemoryStudentQueryService implements IStudentQueryService {
  final InMemoryStudentRepository _repository;

  InMemoryStudentQueryService(this._repository);

  @override
  GetMyProfileUseCaseDto? getMyProfileById(StudentId studentId) {
    final student = _repository.findById(studentId);
    if (student == null) {
      return null;
    }
    return GetMyProfileUseCaseDto(
      studentName: student.studentName.value,
      profilePhotoPath: student.profilePhotoPath.value,
      status: student.status,
      questionCount: student.questionCount.value,
    );
  }
}
