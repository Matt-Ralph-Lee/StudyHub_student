import '../../../domain/report/models/i_teacher_report_repository.dart';
import '../../../domain/report/models/teacher_report.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryReportRepository implements ITeacherReportRepository {
  late Map<StudentId, List<TeacherReport>> store;
  static final InMemoryReportRepository _instance =
      InMemoryReportRepository._internal();

  factory InMemoryReportRepository() {
    return _instance;
  }

  InMemoryReportRepository._internal() {
    store = {};
  }

  @override
  Future<void> submit(final TeacherReport report) async {
    if (store.containsKey(report.from)) {
      final data = store[report.from];
      data!.add(report);
      store[report.from] = data;
    } else {
      store[report.from] = [report];
    }
  }
}
