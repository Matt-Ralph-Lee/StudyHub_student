import '../../../domain/student/models/student_id.dart';

abstract class IGetMyQuestionsQueryService {
  List<> getWithMostLikedAnswer(final StudentId studentId);
}
