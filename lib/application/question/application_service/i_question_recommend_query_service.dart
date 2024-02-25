import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class IQuestionRecommendQueryService {
  List<QuestionCardDto> getWithMostLikedAnswer({
    final Subject? subject,
    required final StudentId studentId,
  });
}
