import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';

abstract class ISearchForQuestionsQueryService {
  List<QuestionCardDto> search({
    required final String searchWord,
    required final Subject? subject,
  });
}
