import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/report/application_service/report_submit_command.dart';
import 'package:studyhub/application/report/application_service/report_submit_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/report/models/report_reason.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/report/in_memory_report_repository.dart';

void main() {
  final repository = InMemoryReportRepository();
  final session = MockSession();

  setUp(() => null);

  group('report submit use case without any error', () {
    test('text has some string', () {
      final teacherId1 = TeacherId('testteacher1234567890');
      const reportReason1 = ReportReason.answerOffensive;
      const reportTextData1 = '誹謗中傷をしている';
      final command = ReportSubmitCommand(
          teacherId: teacherId1,
          reportReason: reportReason1,
          reportTextData: reportTextData1);
      final usecase =
          ReportSubmitUseCase(repository: repository, session: session);
      usecase.execute(command);

      expect(repository.store[session.studentId]!.first.text!.value,
          reportTextData1);
    });

    test('with no text', () {
      final teacherId1 = TeacherId('newtestteacher1234567890');
      const reportReason1 = ReportReason.answerIncorrect;
      final command = ReportSubmitCommand(
          teacherId: teacherId1,
          reportReason: reportReason1,
          reportTextData: null);
      final usecase =
          ReportSubmitUseCase(repository: repository, session: session);
      usecase.execute(command);

      expect(repository.store[session.studentId]![1].to, teacherId1);
      expect(repository.store[session.studentId]![1].text, null);
    });

    test('with empty text', () {
      final teacherId1 = TeacherId('brandnewtestteacher1234567890');
      const reportReason1 = ReportReason.answerIrrelevant;
      const emptyText = '';
      final command = ReportSubmitCommand(
          teacherId: teacherId1,
          reportReason: reportReason1,
          reportTextData: emptyText);
      final usecase =
          ReportSubmitUseCase(repository: repository, session: session);
      usecase.execute(command);

      expect(repository.store[session.studentId]![2].to, teacherId1);
      expect(repository.store[session.studentId]![2].text, null);
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
