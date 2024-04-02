import 'question_report.dart';

abstract class IQuestionReportRepository {
  void submit(final QuestionReport report);
}
