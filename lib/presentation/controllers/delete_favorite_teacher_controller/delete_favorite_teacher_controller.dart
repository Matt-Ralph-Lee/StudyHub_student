import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/favorite_teacher/repository/favorite_teacher_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/favorite_teachers_delete_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";

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
  }
}
