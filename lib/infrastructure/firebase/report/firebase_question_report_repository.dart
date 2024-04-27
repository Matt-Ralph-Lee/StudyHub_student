import '../../../domain/report/models/i_question_report_repository.dart';
import '../../../domain/report/models/question_report.dart';
import '../database.dart';

class FirebaseQuestionReportRepository implements IQuestionReportRepository {
  final db = Database.db;

  static final FirebaseQuestionReportRepository _instance =
      FirebaseQuestionReportRepository._internal();

  factory FirebaseQuestionReportRepository() {
    return _instance;
  }

  FirebaseQuestionReportRepository._internal();

  @override
  Future<void> submit(QuestionReport report) async {
    final addData = <String, dynamic>{};

    addData["subject"] = "question";
    addData["from"] = report.from.value;
    addData["about"] = report.about.value;
    addData["reason"] = report.reason.english;
    addData["text"] = report.text.value;

    await db.collection("reports").add(addData);
  }
}
