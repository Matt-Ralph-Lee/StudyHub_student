import 'teacher_report.dart';

abstract class ITeacherReportRepository {
  Future<void> submit(final TeacherReport report);
}
