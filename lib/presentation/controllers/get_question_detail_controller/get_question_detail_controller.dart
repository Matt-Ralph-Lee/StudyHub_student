import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/bookmarks/repository/bookmarks_repository_provider.dart";
import "../../../application/di/interfaces/logger_provider.dart";
import "../../../application/di/question_detail/question_detail_query_service_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_provider.dart";
import "../../../application/question/application_service/get_question_detail_use_case.dart";
import "../../../application/question/application_service/question_detail_dto.dart";
import "../../../domain/question/models/question_id.dart";

part "get_question_detail_controller.g.dart";

@riverpod
class GetQuestionDetailController extends _$GetQuestionDetailController {
  @override
  Future<QuestionDetailDto> build(final QuestionId questionId) async {
    final getQuestionDetailQueryService =
        ref.watch(getQuestionDetailQueryServiceDiProvider);
    final studentRepository = ref.watch(studentRepositoryDiProvider);
    final bookmarksRepository = ref.watch(bookmarksRepositoryDiProvider);
    final logger = ref.read(loggerDiProvider);

    final getQuestionDetailUseCase = GetQuestionDetailUseCase(
      queryService: getQuestionDetailQueryService,
      studentRepository: studentRepository,
      bookmarksRepository: bookmarksRepository,
      logger: logger,
    );

    final session = ref.read(nonNullSessionProvider);
    final studentId = session.studentId;

    final questionCardDto = getQuestionDetailUseCase.execute(
      questionId: questionId,
      studentId: studentId,
    );
    return questionCardDto;
  }
}
