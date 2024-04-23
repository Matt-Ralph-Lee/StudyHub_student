import '../../student/models/student_id.dart';
import '../../question/models/question_id.dart';
import 'report_reason.dart';
import 'report_text.dart';

class QuestionReport {
  final StudentId from;
  final QuestionId about;
  final ReportReason reason;
  final ReportText text;

  QuestionReport(
      {required this.from,
      required this.about,
      required this.reason,
      required this.text});
}
