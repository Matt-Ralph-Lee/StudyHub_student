import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/report/teacher_report_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/report/application_service/teacher_report_submit_command.dart";
import "../../../application/report/application_service/teacher_report_submit_use_case.dart";
part "report_teacher_controller.g.dart";

@riverpod
class ReportTeacherController extends _$ReportTeacherController {
  @override
  Future<void> build() async {}

  Future<void> reportTeacher(final TeacherReportSubmitCommand command) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.watch(nonNullSessionProvider);
      final teacherReportRepository =
          ref.read(teacherReportRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);

      final reportTeacherUseCase = TeacherReportSubmitUseCase(
        session: session,
        repository: teacherReportRepository,
        logger: logger,
      );
      reportTeacherUseCase.execute(command);
    });
  }
}
