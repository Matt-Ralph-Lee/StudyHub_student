import '../../../domain/student/models/student_id.dart';
import 'i_get_liked_answers_query_service.dart';
import 'liked_answers_dto.dart';

class GetAnswerUseCase {
  final IGetLikedAnswersQueryService _queryService;

  GetAnswerUseCase(this._queryService);

  LikedAnswersDto execute(final StudentId studentId) {
    final answers = _queryService.getByStudentId(studentId);
    return answers;
  }
}
