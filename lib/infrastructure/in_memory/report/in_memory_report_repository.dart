import '../../../domain/report/models/i_report_repository.dart';
import '../../../domain/report/models/report.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryReportRepository implements IReportRepository {
  final store = <StudentId, List<Report>>{};

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
