import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/report/question_report_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/report/application_service/question_report_submit_command.dart";
import "../../../application/report/application_service/question_report_submit_use_case.dart";
part "report_question_controller.g.dart";

@riverpod
class ReportQuestionController extends _$ReportQuestionController {
  @override
  Future<void> build() async {}

  Future<void> reportQuestion(final QuestionReportSubmitCommand command) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.watch(nonNullSessionProvider);
      final questionReportRepository =
          ref.read(questionReportRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);

      final reportQuestionUseCase = QuestionReportSubmitUseCase(
        session: session,
        repository: questionReportRepository,
        logger: logger,
      );

      reportQuestionUseCase.execute(command);
    });
  }
}
