import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/favorite_teachers/application_service/get_favorite_teacher_use_case.dart";

part "favorite_teachers_controller.g.dart";

@riverpod
class FavoriteTeacherController extends _$FavoriteTeacherController {
  @override
  Future<void> build() async {}

  void fetchFavoriteTeachers() async {
    final getFavoriteTeacherUseCase =
        GetFavoriteTeacherUseCase(session: null, queryService: null);
    state = const AsyncLoading();
    final favoriteTeachers = getFavoriteTeacherUseCase.execute();
    state = AsyncValue.data(getFavoriteTeacherUseCase);
  }
}
