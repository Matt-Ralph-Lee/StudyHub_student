import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/answer/application_service/decrement_answer_like_use_case.dart";
import "../../../application/answer/application_service/increment_answer_like_use_case.dart";
import "../../../application/di/answer/repository/answer_repository_provider.dart";
import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/liked_answers/repository/liked_answers_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/answer_list/models/answer_id.dart";
import "../../../domain/question/models/question_id.dart";
import "../get_answer_controller/get_answer_controller.dart";

part 'like_answer_controller.g.dart';

@riverpod
class LikeAnswerController extends _$LikeAnswerController {
  @override
  Future<void> build() async {}

  Future<void> increment({
    required final AnswerId answerId,
    required final QuestionId questionId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final answerRepository = ref.read(answerRepositoryDiProvider);
      final likedAnswerRepository = ref.read(likedAnswersRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final incrementAnswerLikeUseCase = IncrementAnswerLikeUseCase(
        repository: answerRepository,
        likedAnswersRepository: likedAnswerRepository,
        logger: logger,
      );

      final session = ref.read(nonNullSessionProvider);
      final studentId = session.studentId;

      await incrementAnswerLikeUseCase.execute(
        studentId: studentId,
        answerId: answerId,
        questionId: questionId,
      );
    });

    ref.invalidate(getAnswerControllerProvider);
  }

  Future<void> decrement(
      {required final AnswerId answerId,
      required final QuestionId questionId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final answerRepository = ref.read(answerRepositoryDiProvider);
      final likedAnswerRepository = ref.read(likedAnswersRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final decrementAnswerLikeUseCase = DecrementAnswerLikeUseCase(
        repository: answerRepository,
        likedAnswersRepository: likedAnswerRepository,
        logger: logger,
      );

      final session = ref.read(nonNullSessionProvider);
      final studentId = session.studentId;

      await decrementAnswerLikeUseCase.execute(
        answerId: answerId,
        studentId: studentId,
        questionId: questionId,
      );
    });

    ref.invalidate(getAnswerControllerProvider);
  }
}
