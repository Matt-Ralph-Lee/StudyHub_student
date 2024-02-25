import '../../../domain/student/models/student_id.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class IGetMyQuestionsQueryService {
  List<QuestionCardDto> getWithMostLikedAnswer(final StudentId studentId);
}
