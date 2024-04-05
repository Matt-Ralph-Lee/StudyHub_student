import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/liked_answer/models/i_liked_answers_repository.dart';
import '../../../domain/liked_answer/models/liked_answers.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/liked_answers/liked_answers_infrastructure_exception.dart';
import '../../exceptions/liked_answers/liked_answers_infrastructure_exception_detail.dart';
import '../answer/in_memory_answer_repository.dart';
import '../student/in_memory_student_repository.dart';

class InMemoryLikedAnswersRepository extends ILikedAnswersRepository {
  late Map<StudentId, Set<AnswerId>> store;
  static final InMemoryLikedAnswersRepository _instance =
      InMemoryLikedAnswersRepository._internal();

  factory InMemoryLikedAnswersRepository() {
    return _instance;
  }

  InMemoryLikedAnswersRepository._internal() {
    store = {
      InMemoryStudentInitialValue.userStudentId: {
        InMemoryAnswerInitialValue.answer2FromT2ToQ2.answerId,
      }
    };
  }

  @override
  Future<LikedAnswers> getByStudentId(StudentId studentId) async {
    final likedAnswers = store[studentId];
    if (likedAnswers == null) {
      return LikedAnswers({});
    }
    return LikedAnswers(likedAnswers);
  }

  @override
  Future<void> add(StudentId studentId, AnswerId answerId) async {
    if (store[studentId] == null) store[studentId] = {answerId};
    store[studentId]!.add(answerId);
  }

  @override
  Future<void> delete(StudentId studentId, AnswerId answerId) async {
    if (store[studentId] == null) {
      throw const LikedAnswersInfrastructureException(
          LikedAnswersInfrastructureExceptionDetail.likedAnswersNotFound);
    }
    store[studentId]!.remove(answerId);
  }
}
