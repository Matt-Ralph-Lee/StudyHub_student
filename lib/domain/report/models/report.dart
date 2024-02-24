import '../../student/models/student_id.dart';
import '../../teacher/models/teacher_id.dart';
import 'report_reason.dart';
import 'report_text.dart';

class Report {
  final StudentId from;
  final TeacherId to;
  final ReportReason reason;
  final ReportText text;

  Report(
      {required this.from,
      required this.to,
      required this.reason,
      required this.text});
}
