import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/blockings/application_service/blockings_add_use_case.dart";
import "../../../application/di/blockings/repository/blockings_repository_provider.dart";
import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_answer_controller/get_answer_controller.dart";
import "../get_favorite_teacher_controller/get_favorite_teacher_controller.dart";
import "../get_my_blockings_controller/get_my_blockings_controller.dart";
import "../get_teacher_profile_controller/get_teacher_profile_controller.dart";

part "add_blockings_controller.g.dart";

@riverpod
class AddBlockingsController extends _$AddBlockingsController {
  @override
  Future<void> build() async {}

  Future<void> addBlockings(final TeacherId teacherId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final blockingsRepository = ref.read(blockingsRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);

      final addBookingsUseCase = BlockingsAddUseCase(
        session: session,
        repository: blockingsRepository,
        logger: logger,
      );

      await addBookingsUseCase.execute(teacherId);
    });

    ref.invalidate(getAnswerControllerProvider);
    ref.invalidate(getFavoriteTeacherControllerProvider);
    ref.invalidate(getTeacherProfileControllerProvider(teacherId));
    ref.invalidate(getBlockingsControllerProvider);
  }
}
