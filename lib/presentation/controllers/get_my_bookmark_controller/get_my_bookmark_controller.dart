import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/bookmarks/application_service/get_my_bookmarks_use_case.dart";
import "../../../application/di/bookmarks/query_service/get_my_bookmarks_query_service_provider.dart";
import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/shared/application_service/question_card_dto.dart";

part "get_my_bookmark_controller.g.dart";

@riverpod
class GetMyBookmarksController extends _$GetMyBookmarksController {
  @override
  Future<List<QuestionCardDto>> build() async {
    final session = ref.watch(sessionDiProvider);
    final queryService = ref.watch(getMyBookmarksQueryServiceDiProvider);
    final logger = ref.read(loggerDiProvider);
    if (session == null) {
      throw Exception('Session is null');
    }

    final getMyBookmarksUseCase = GetMyBookmarksUseCase(
      session: session,
      queryService: queryService,
      logger: logger,
    );

    final questionCardDto = getMyBookmarksUseCase.execute();
    return questionCardDto;
  }
}
