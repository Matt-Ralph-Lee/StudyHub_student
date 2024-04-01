import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/teacher/get_popular_teacher_query_service_provider.dart";
import "../../../application/teacher/application_service/get_popular_teachers_use_case.dart";
import "../../../application/teacher/application_service/search_for_teachers_dto.dart";

part "get_popular_teacher_controller.g.dart";

@riverpod
class GetPopularTeacherController extends _$GetPopularTeacherController {
  @override
  Future<List<SearchForTeacherDto>?> build() async {
    final queryService = ref.watch(getPopularTeacherQueryServiceDiProvider);
    final getPopularTeachesUseCase = GetPopularTeachersUseCase(queryService);
    final favoriteTeachers = getPopularTeachesUseCase.execute();
    return favoriteTeachers;
  }
}
