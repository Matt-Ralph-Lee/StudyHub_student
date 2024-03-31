import '../../answer_list/models/answer_id.dart';
import '../../student/models/student_id.dart';
import 'liked_answers.dart';

abstract class ILikedAnswersRepository {
  LikedAnswers getByStudentId(final StudentId studentId);
  void add(final StudentId studentId, final AnswerId answerId);
  void delete(final StudentId studentId, final AnswerId answerId);
}
