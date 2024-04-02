import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/report/application_service/teacher_report_submit_command.dart';
import 'package:studyhub/application/report/application_service/teacher_report_submit_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/report/models/report_reason.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/report/in_memory_teacher_report_repository.dart';

void main() {
  final repository = InMemoryReportRepository();
  final session = MockSession();

  setUp(() => null);

  group('report submit use case without any error', () {
    test('text has some string', () {
      final teacherId1 = TeacherId('testteacher1234567890');
      const reportReason1 = ReportReason.answerOffensive;
      const reportTextData1 = '誹謗中傷をしている';
      final command = TeacherReportSubmitCommand(
          teacherId: teacherId1,
          reportReason: reportReason1,
          reportTextData: reportTextData1);
      final usecase =
          TeacherReportSubmitUseCase(repository: repository, session: session);
      usecase.execute(command);

      expect(repository.store[session.studentId]!.first.text.value,
          reportTextData1);
    });

    test('with empty text', () {
      final teacherId1 = TeacherId('newtestteacher1234567890');
      const reportReason1 = ReportReason.answerIncorrect;
      const emptyText = '';
      final command = TeacherReportSubmitCommand(
          teacherId: teacherId1,
          reportReason: reportReason1,
          reportTextData: emptyText);
      final usecase =
          TeacherReportSubmitUseCase(repository: repository, session: session);
      usecase.execute(command);

      expect(repository.store[session.studentId]![1].to, teacherId1);
      expect(repository.store[session.studentId]![1].text.value, emptyText);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
