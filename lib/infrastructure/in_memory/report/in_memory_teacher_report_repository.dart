import '../../../domain/report/models/i_teacher_report_repository.dart';
import '../../../domain/report/models/teacher_report.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryTeacherReportRepository implements ITeacherReportRepository {
  late Map<StudentId, List<TeacherReport>> store;
  static final InMemoryTeacherReportRepository _instance =
      InMemoryTeacherReportRepository._internal();

  factory InMemoryTeacherReportRepository() {
    return _instance;
  }

  InMemoryTeacherReportRepository._internal() {
    store = {};
  }

  @override
  void submit(final TeacherReport report) {
    if (store.containsKey(report.from)) {
      final data = store[report.from];
      data!.add(report);
      store[report.from] = data;
    } else {
      store[report.from] = [report];
    }
  }
}
