import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/question/repository/question_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/question/application_service/resolve_question_use_case.dart";
import "../../../domain/question/models/question_id.dart";

part "resolve_question_controller.g.dart";

@riverpod
class ResolveQuestionController extends _$ResolveQuestionController {
  @override
  Future<void> build() async {}

  Future<void> resolveQuestion(
    QuestionId questionId,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final questionRepository = ref.read(questionRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final resolveQuestionUseCase = ResolveQuestionUseCase(
        repository: questionRepository,
        logger: logger,
      );

      await resolveQuestionUseCase.execute(
        studentId: session.studentId,
        questionId: questionId,
      );
    });
  }
}
