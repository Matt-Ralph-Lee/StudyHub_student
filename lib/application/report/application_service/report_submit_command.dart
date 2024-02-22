import '../../../domain/report/models/report_reason.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class ReportSubmitCommand {
  final TeacherId _teacherId;
  final ReportReason _reportReason;
  final String? _reportTextData;

  TeacherId get teacherId => _teacherId;
  ReportReason get reportReason => _reportReason;
  String? get reportTextData => _reportTextData;

  ReportSubmitCommand({
    required final TeacherId teacherId,
    required final ReportReason reportReason,
    required final String? reportTextData,
  })  : _teacherId = teacherId,
        _reportReason = reportReason,
        _reportTextData = reportTextData;
}
