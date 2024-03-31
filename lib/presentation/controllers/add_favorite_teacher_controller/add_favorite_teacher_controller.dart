import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/favorite_teacher/repository/favorite_teacher_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/favorite_teachers_add_use_case.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_answer_controller/get_answer_controller.dart";
import "../get_favorite_teacher_controller/get_favorite_teacher_controller.dart";
import "../get_teacher_profile_controller/get_teacher_profile_controller.dart";

part "add_favorite_teacher_controller.g.dart";

@riverpod
class AddFavoriteTeacherController extends _$AddFavoriteTeacherController {
  @override
  Future<void> build() async {}

  Future<void> addFavoriteTeacher(TeacherId teacherId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final favoriteTeacherRepository =
          ref.read(favoriteTeacherRepositoryDiProvider);
      final addFavoriteTeacherUseCase = FavoriteTeachersAddUseCase(
        session: session,
        repository: favoriteTeacherRepository,
      );
      await addFavoriteTeacherUseCase.execute(teacherId);
    });

    ref.invalidate(getAnswerControllerProvider);
    ref.invalidate(getFavoriteTeacherControllerProvider);
    ref.invalidate(getTeacherProfileControllerProvider(teacherId));
  }
}
