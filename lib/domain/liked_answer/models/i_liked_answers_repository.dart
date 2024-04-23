import '../../answer_list/models/answer_id.dart';
import '../../student/models/student_id.dart';
import 'liked_answers.dart';

abstract class ILikedAnswersRepository {
  Future<LikedAnswers> getByStudentId(final StudentId studentId);
  Future<void> add(final StudentId studentId, final AnswerId answerId);
  Future<void> delete(final StudentId studentId, final AnswerId answerId);
}
