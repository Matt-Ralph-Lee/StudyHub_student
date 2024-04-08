import '../../../application/liked_answers/application_service/i_get_liked_answers_query_service.dart';
import '../../../application/liked_answers/application_service/liked_answers_dto.dart';
import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/student/models/student_id.dart';
import 'firebase_liked_answers_repository.dart';

class FirebaseGetLikedAnswersQueryService
    implements IGetLikedAnswersQueryService {
  final FirebaseLikedAnswersRepository _repository;

  FirebaseGetLikedAnswersQueryService(this._repository);

  @override
  Future<LikedAnswersDto> getByStudentId(StudentId studentId) async {
    final likedAnswers = await _repository.getByStudentId(studentId);

    final likedAnswerSet = <AnswerId>{};

    for (final likedAnswer in likedAnswers) {
      likedAnswerSet.add(likedAnswer);
    }

    return LikedAnswersDto(likedAnswerSet);
  }
}
