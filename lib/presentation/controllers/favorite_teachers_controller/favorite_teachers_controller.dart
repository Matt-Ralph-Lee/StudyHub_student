import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/favorite_teacher/query_service/get_favorite_teacher_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_use_case.dart";

part "favorite_teachers_controller.g.dart";

@riverpod
class FavoriteTeacherController extends _$FavoriteTeacherController {
  /*
  Future<void> fetchFavoriteTeachers() async {
    final session = ref.read(sessionDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getFavoriteTeacherUseCase = GetFavoriteTeacherUseCase(
        session: session,
        queryService: ref.read(getFavoriteTeacherQueryServiceDiProvider));

    state = const AsyncLoading();
    final favoriteTeachers = getFavoriteTeacherUseCase.execute();
    state = AsyncValue.data(favoriteTeachers);
  }
  */

  @override
  Future<List<GetFavoriteTeacherDto>> build() async {
    final session = ref.read(nonNullSessionProvider);
    if (session == null) {
      throw Exception('Session cannot be null.');
    }
    final queriService = ref.watch(getFavoriteTeacherQueryServiceDiProvider);
    if (queriService == null) {
      throw Exception('queriService cannot be null.');
    }
    final getFavoriteTeacherUseCase =
        GetFavoriteTeacherUseCase(session: session, queryService: queriService);
    if (getFavoriteTeacherUseCase == null) {
      throw Exception('getFavoriteTeacherUseCase cannot be null.');
    }

    final favoriteTeachers = getFavoriteTeacherUseCase.execute();
    if (favoriteTeachers == null) {
      throw Exception('favoriteTeachers cannot be null.');
    }
    return favoriteTeachers;
  }
}
