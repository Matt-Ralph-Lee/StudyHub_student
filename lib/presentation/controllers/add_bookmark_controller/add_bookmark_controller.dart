import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/bookmarks/application_service/bookmarks_add_use_case.dart";
import "../../../application/di/bookmarks/repository/bookmarks_repository_provider.dart";
import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/question/models/question_id.dart";
import "../get_my_bookmark_controller/get_my_bookmark_controller.dart";
import "../get_question_detail_controller/get_question_detail_controller.dart";

part "add_bookmark_controller.g.dart";

@riverpod
class AddBookmarkController extends _$AddBookmarkController {
  @override
  Future<void> build() async {}

  Future<void> addBookmark(final QuestionId questionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final repository = ref.watch(bookmarksRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final addBookmarkUseCase = BookmarksAddUseCase(
        session: session,
        repository: repository,
        logger: logger,
      );
      await addBookmarkUseCase.execute(questionId);
    });
    ref.invalidate(getQuestionDetailControllerProvider);
    ref.invalidate(getMyBookmarksControllerProvider);
  }
}
