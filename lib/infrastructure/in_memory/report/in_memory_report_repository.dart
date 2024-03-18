import '../../../domain/report/models/i_report_repository.dart';
import '../../../domain/report/models/report.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryReportRepository implements IReportRepository {
  late Map<StudentId, List<Report>> store;
  static final InMemoryReportRepository _instance =
      InMemoryReportRepository._internal();

  factory InMemoryReportRepository() {
    return _instance;
  }

  InMemoryReportRepository._internal() {
    store = {};
  }

  @override
  void submit(final Report report) {
    if (store.containsKey(report.from)) {
      final data = store[report.from];
      data!.add(report);
    } else {
      store[report.from] = [report];
    }
  }
}
