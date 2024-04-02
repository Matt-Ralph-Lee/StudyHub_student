import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class IGetTrendingQuestionQueryService {
  List<QuestionCardDto> get(final Subject? subject);
}
