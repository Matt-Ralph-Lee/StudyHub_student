import 'question_report.dart';

abstract class IQuestionReportRepository {
  Future<void> submit(final QuestionReport report);
}
