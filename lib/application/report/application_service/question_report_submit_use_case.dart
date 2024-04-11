import '../../../domain/report/models/i_question_report_repository.dart';
import '../../../domain/report/models/question_report.dart';
import '../../../domain/report/models/report_text.dart';
import '../../shared/session/session.dart';
import 'question_report_submit_command.dart';

class QuestionReportSubmitUseCase {
  final Session _session;
  final IQuestionReportRepository _repository;

  QuestionReportSubmitUseCase({
    required final IQuestionReportRepository repository,
    required final Session session,
  })  : _repository = repository,
        _session = session;

  Future<void> execute(final QuestionReportSubmitCommand command) async {
    final studentId = _session.studentId;
    final targetQuestionId = command.questionId;
    final reportReason = command.reportReason;
    final reportTextData = command.reportTextData;
    final reportText = ReportText(reportTextData);

    final report = QuestionReport(
        from: studentId,
        about: targetQuestionId,
        reason: reportReason,
        text: reportText);

    await _repository.submit(report);
  }
}
