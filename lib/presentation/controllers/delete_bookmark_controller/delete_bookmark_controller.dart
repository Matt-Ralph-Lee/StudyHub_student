import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/bookmarks/application_service/bookmarks_delete_use_case.dart";
import "../../../application/di/bookmarks/repository/bookmarks_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/question/models/question_id.dart";

part "delete_bookmark_controller.g.dart";

@riverpod
class DeleteBookmarkController extends _$DeleteBookmarkController {
  @override
  Future<void> build() async {}

  Future<void> deleteBookmark(QuestionId questionId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final repository = ref.watch(bookmarksRepositoryDiProvider);
      final deleteBookmarkUseCase = BookmarksDeleteUseCase(
        session: session,
        repository: repository,
      );
      await deleteBookmarkUseCase.execute(questionId);
    });
  }
}
