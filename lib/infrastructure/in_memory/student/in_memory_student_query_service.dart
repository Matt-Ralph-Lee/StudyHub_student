import '../../../application/student/application_service/get_my_profile_dto.dart';
import '../../../application/student/application_service/i_get_my_profile_query_service.dart';
import '../../../domain/student/models/student_id.dart';
import 'in_memory_student_repository.dart';

class InMemoryGetMyProfileQueryService implements IGetMyProfileQueryService {
  final InMemoryStudentRepository _repository;

  InMemoryGetMyProfileQueryService(this._repository);

  @override
  Future<GetMyProfileDto?> getById(StudentId studentId) async {
    final student = await _repository.findById(studentId);
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
