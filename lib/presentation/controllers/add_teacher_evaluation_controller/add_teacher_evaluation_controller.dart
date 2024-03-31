import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/answer/repository/answer_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/teacher_evaluation/teacher_evaluation_repository_provider.dart";
import "../../../application/teacher_evaluation/application_service/teacher_evaluation_add_use_case.dart";
import "../../../domain/answer_list/models/answer_id.dart";
import "../../../domain/question/models/question_id.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_answer_controller/get_answer_controller.dart";

part "add_teacher_evaluation_controller.g.dart";

@riverpod
class AddTeacherEvaluationController extends _$AddTeacherEvaluationController {
  @override
  Future<void> build() async {}

  Future<void> addTeacherEvaluation({
    required final AnswerId answerId,
    required final QuestionId questionId,
    required final TeacherId teacherId,
    required final int ratingData,
    required final String commentData,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session =
          ref.read(nonNullSessionProvider); //普通のsession or nonNullSession
      final teacherEvaluationRepository =
          ref.read(teacherEvaluationRepositoryDiProvider);
      final answerRepository = ref.read(answerRepositoryDiProvider);
      final addTeacherEvaluationUseCase = TeacherEvaluationAddUseCase(
        session: session,
        repository: teacherEvaluationRepository,
        answerRepository: answerRepository,
      );
      await addTeacherEvaluationUseCase.execute(
        answerId: answerId,
        to: teacherId,
        ratingData: ratingData,
        commentData: commentData,
      );
    });

    ref.invalidate(getAnswerControllerProvider(questionId));
  }
}
