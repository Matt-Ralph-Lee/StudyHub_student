import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/teacher/search_for_teachers_query_service.dart";
import "../../../application/teacher/application_service/search_for_teachers_dto.dart";
import "../../../application/teacher/application_service/search_for_teachers_use_case.dart";

part "search_for_teachers_controller.g.dart";

@riverpod
class SearchForTeachersController extends _$SearchForTeachersController {
  @override
  Future<List<SearchForTeacherDto>?> build(final String searchTerm) async {
    final queryService = ref.watch(searchForTeachersQueryServiceDiProvider);
    final logger = ref.read(loggerDiProvider);
    final searchForTeachersUseCase = SearchForTeachersUseCase(
      queryService: queryService,
      logger: logger,
    );

    final getTeacherProfileDto = searchForTeachersUseCase.execute(searchTerm);
    return getTeacherProfileDto;
  }
}
