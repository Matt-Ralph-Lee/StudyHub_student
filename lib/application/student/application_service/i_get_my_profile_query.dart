import '../../../domain/student/models/student_id.dart';
import 'get_my_profile_use_case_dto.dart';

abstract class IStudentQueryService {
  GetMyProfileUseCaseDto? getMyProfileById(final StudentId studentId);
}
