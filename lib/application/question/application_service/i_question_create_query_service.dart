import '../../../domain/shared/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';

abstract class IQuestionCreateQueryService {
  Future<ProfilePhotoPath> getProfilePhotoPath(final StudentId studentId);
}
