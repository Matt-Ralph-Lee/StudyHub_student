import '../../../domain/student/models/student_id.dart';
import 'liked_answers_dto.dart';

abstract class IGetLikedAnswersQueryService {
  Future<LikedAnswersDto> getByStudentId(final StudentId studentId);
}
