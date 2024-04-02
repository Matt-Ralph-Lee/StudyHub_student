import 'teacher_report.dart';

abstract class ITeacherReportRepository {
  void submit(final TeacherReport report);
}
