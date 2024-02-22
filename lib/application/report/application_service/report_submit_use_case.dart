import '../../../domain/report/models/i_report_repository.dart';
import '../../../domain/report/models/report.dart';
import '../../../domain/report/models/report_text.dart';
import '../../shared/session/session.dart';
import 'report_submit_command.dart';

class ReportSubmitUseCase {
  final Session _session;
  final IReportRepository _repository;

  ReportSubmitUseCase({
    required final IReportRepository repository,
    required final Session session,
  })  : _repository = repository,
        _session = session;

  void execute(final ReportSubmitCommand command) {
    final studentId = _session.studentId;
    final targetTeacherId = command.teacherId;
    final reportReason = command.reportReason;
    final reportTextData = command.reportTextData;

    final ReportText? reportText;
    if (reportTextData != null && reportTextData.isNotEmpty) {
      reportText = ReportText(reportTextData);
    } else {
      reportText = null;
    }

    final report = Report(
        from: studentId,
        to: targetTeacherId,
        reason: reportReason,
        text: reportText);

    _repository.submit(report);
  }
}
