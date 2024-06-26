import '../../../domain/report/models/i_question_report_repository.dart';
import '../../../domain/report/models/question_report.dart';
import '../../../domain/student/models/student_id.dart';

class InMemoryQuestionReportRepository implements IQuestionReportRepository {
  late Map<StudentId, List<QuestionReport>> store;
  static final InMemoryQuestionReportRepository _instance =
      InMemoryQuestionReportRepository._internal();

  factory InMemoryQuestionReportRepository() {
    return _instance;
  }

  InMemoryQuestionReportRepository._internal() {
    store = {};
  }

  @override
  Future<void> submit(QuestionReport report) async {
    if (store.containsKey(report.from)) {
      final data = store[report.from];
      data!.add(report);
      store[report.from] = data;
    } else {
      store[report.from] = [report];
    }
  }
}
