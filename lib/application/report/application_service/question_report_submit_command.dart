import '../../../domain/question/models/question_id.dart';
import '../../../domain/report/models/report_reason.dart';

class QuestionReportSubmitCommand {
  final QuestionId _questionId;
  final ReportReason _reportReason;
  final String _reportTextData;

  QuestionId get questionId => _questionId;
  ReportReason get reportReason => _reportReason;
  String get reportTextData => _reportTextData;

  QuestionReportSubmitCommand({
    required final QuestionId questionId,
    required final ReportReason reportReason,
    required final String reportTextData,
  })  : _questionId = questionId,
        _reportReason = reportReason,
        _reportTextData = reportTextData;
}
