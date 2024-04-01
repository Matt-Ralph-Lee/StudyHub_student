import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/presentation/controllers/get_answer_controller/get_answer_controller.dart";

import "../../../application/answer/application_service/decrement_answer_like_use_case.dart";
import "../../../application/answer/application_service/increment_answer_like_use_case.dart";
import "../../../application/di/answer/repository/answer_repository_provider.dart";
import "../../../application/di/liked_answers/repository/liked_answers_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/answer_list/models/answer_id.dart";

part 'like_answer_controller.g.dart';

@riverpod
class LikeAnswerController extends _$LikeAnswerController {
  @override
  Future<void> build() async {}

  void increment(final AnswerId answerId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final answerRepository = ref.read(answerRepositoryDiProvider);
      final likedAnswerRepository = ref.read(likedAnswersRepositoryDiProvider);
      final incrementAnswerLikeUseCase = IncrementAnswerLikeUseCase(
          repository: answerRepository,
          likedAnswersRepository: likedAnswerRepository);

      final session = ref.read(nonNullSessionProvider);
      final studentId = session.studentId;

      incrementAnswerLikeUseCase.execute(
          studentId: studentId, answerId: answerId);
    });

    ref.invalidate(getAnswerControllerProvider);
  }

  void decrement(final AnswerId answerId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final answerRepository = ref.read(answerRepositoryDiProvider);
      final likedAnswerRepository = ref.read(likedAnswersRepositoryDiProvider);
      final decrementAnswerLikeUseCase = DecrementAnswerLikeUseCase(
          repository: answerRepository,
          likedAnswersRepository: likedAnswerRepository);

      final session = ref.read(nonNullSessionProvider);
      final studentId = session.studentId;

      decrementAnswerLikeUseCase.execute(
          answerId: answerId, studentId: studentId);
    });

    ref.invalidate(getAnswerControllerProvider);
  }
}
