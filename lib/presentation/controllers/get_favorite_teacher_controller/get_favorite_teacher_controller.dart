import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/favorite_teacher/query_service/get_favorite_teacher_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_dto.dart";
import "../../../application/favorite_teachers/application_service/get_favorite_teacher_use_case.dart";

part "get_favorite_teacher_controller.g.dart";

@riverpod
class GetFavoriteTeacherController extends _$GetFavoriteTeacherController {
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
    final queryService = ref.watch(getFavoriteTeacherQueryServiceDiProvider);
    final getFavoriteTeacherUseCase =
        GetFavoriteTeacherUseCase(session: session, queryService: queryService);
    final favoriteTeachers = getFavoriteTeacherUseCase.execute();
    return favoriteTeachers;
  }
}
