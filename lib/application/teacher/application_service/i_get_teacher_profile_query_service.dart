import '../../../domain/teacher/models/teacher_id.dart';
import 'get_teacher_profile_dto.dart';

abstract class IGetTeacherProfileQueryService {
  GetTeacherProfileDto? findById(final TeacherId teacherId);
}
