import '../../../domain/student/models/student_id.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class IGetBookmarksQueryService {
  List<QuestionCardDto> getByStudentId(final StudentId studentId);
}
