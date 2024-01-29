import '../../../domain/student/models/student_id.dart';
import 'get_my_profile_dto.dart';

abstract class IGetMyProfileQueryService {
  GetMyProfileDto? getById(final StudentId studentId);
}
