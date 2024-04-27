import '../database.dart';

import '../../../domain/report/models/i_teacher_report_repository.dart';
import '../../../domain/report/models/teacher_report.dart';

class FirebaseTeacherReportRepository implements ITeacherReportRepository {
  final db = Database.db;

  static final FirebaseTeacherReportRepository _instance =
      FirebaseTeacherReportRepository._internal();

  factory FirebaseTeacherReportRepository() {
    return _instance;
  }

  FirebaseTeacherReportRepository._internal();

  @override
  Future<void> submit(TeacherReport report) async {
    final addData = <String, dynamic>{};

    addData["subject"] = "teacher";
    addData["from"] = report.from.value;
    addData["to"] = report.to.value;
    addData["reason"] = report.reason.english;
    addData["text"] = report.text.value;

    await db.collection("reports").add(addData);
  }
}
