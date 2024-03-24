import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/session/session_provider.dart";
import "../../../application/di/teacher_evaluation/teacher_evaluation_repository_provider.dart";
import "../../../application/teacher_evaluation/application_service/teacher_evaluation_add_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";

part "add_teacher_evaluation_controller.g.dart";

@riverpod
class AddTeacherEvaluationController extends _$AddTeacherEvaluationController {
  @override
  Future<void> build() async {}

  Future<void> addTeacherEvaluation(
    TeacherId teacherId,
    int ratingData,
    String commentData,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session =
          ref.read(nonNullSessionProvider); //普通のsession or nonNullSession
      final teacherEvaluationRepository =
          ref.read(teacherEvaluationRepositoryDiProvider);
      final addTeacherEvaluationUseCase = TeacherEvaluationAddUseCase(
        session: session,
        repository: teacherEvaluationRepository,
      );
      await addTeacherEvaluationUseCase.execute(
        to: teacherId,
        ratingData: ratingData,
        commentData: commentData,
      );
    });
  }
}
