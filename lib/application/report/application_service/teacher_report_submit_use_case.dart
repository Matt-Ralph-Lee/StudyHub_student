import '../../../domain/report/models/i_teacher_report_repository.dart';
import '../../../domain/report/models/teacher_report.dart';
import '../../../domain/report/models/report_text.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/session/session.dart';
import 'teacher_report_submit_command.dart';

class TeacherReportSubmitUseCase {
  final Session _session;
  final ITeacherReportRepository _repository;
  final ILogger _logger;

  TeacherReportSubmitUseCase({
    required final ITeacherReportRepository repository,
    required final Session session,
    required final ILogger logger,
  })  : _repository = repository,
        _session = session,
        _logger = logger;

  Future<void> execute(final TeacherReportSubmitCommand command) async {
    _logger.info('BEGIN $TeacherReportSubmitUseCase.execute()');

    final studentId = _session.studentId;
    final targetTeacherId = command.teacherId;
    final reportReason = command.reportReason;
    final reportTextData = command.reportTextData;
    final reportText = ReportText(reportTextData);

    final report = TeacherReport(
        from: studentId,
        to: targetTeacherId,
        reason: reportReason,
        text: reportText);

    await _repository.submit(report);

    _logger.info('END $TeacherReportSubmitUseCase.execute()');
  }
}
