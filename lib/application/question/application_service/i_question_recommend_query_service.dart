
import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';

abstract class IQuestionRecommendQueryService {
  List<> getWithMostLikedAnswer(final Subject? subject, {required final StudentId studentId});
}