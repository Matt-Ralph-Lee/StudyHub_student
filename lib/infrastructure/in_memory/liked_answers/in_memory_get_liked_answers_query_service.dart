import '../../../application/liked_answers/application_service/i_get_liked_answers_query_service.dart';
import '../../../application/liked_answers/application_service/liked_answers_dto.dart';
import '../../../application/shared/session/session.dart';
import '../../../domain/student/models/student_id.dart';
import 'in_memory_liked_answers_repository.dart';

class InMemoryGetLikedAnswersQueryService extends IGetLikedAnswersQueryService {
  final Session _session;
  final InMemoryLikedAnswersRepository _repository;

  InMemoryGetLikedAnswersQueryService({
    required final Session session,
    required final InMemoryLikedAnswersRepository repository,
  })  : _session = session,
        _repository = repository;

  @override
  Future<LikedAnswersDto> getByStudentId(StudentId studentId) async {
    final studentId = _session.studentId;

    final likedAnswers = await _repository.getByStudentId(studentId);

    return LikedAnswersDto(likedAnswers.value);
  }
}
