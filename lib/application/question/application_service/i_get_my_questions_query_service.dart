import '../../../domain/student/models/student_id.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class IGetMyQuestionsQueryService {
  Future<List<QuestionCardDto>> get(final StudentId studentId);
}
