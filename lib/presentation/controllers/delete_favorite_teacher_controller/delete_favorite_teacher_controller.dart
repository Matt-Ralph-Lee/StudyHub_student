import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/presentation/controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart";
import "package:studyhub/presentation/controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart";

import "../../../application/di/favorite_teacher/repository/favorite_teacher_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/favorite_teachers_delete_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_answer_controller/get_answer_controller.dart";

part "delete_favorite_teacher_controller.g.dart";

@riverpod
class DeleteFavoriteTeacherController
    extends _$DeleteFavoriteTeacherController {
  @override
  Future<void> build() async {}

  Future<void> deleteFavoriteTeacher(TeacherId teacherId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final favoriteTeacherRepository =
          ref.read(favoriteTeacherRepositoryDiProvider);
      final deleteFavoriteTeacherUseCase = FavoriteTeachersDeleteUseCase(
        session: session,
        repository: favoriteTeacherRepository,
      );
      await deleteFavoriteTeacherUseCase.execute(teacherId);
    });
    ref.invalidate(getAnswerControllerProvider);
    ref.invalidate(getFavoriteTeacherControllerProvider);
    ref.invalidate(getTeacherProfileControllerProvider(teacherId));
  }
}
