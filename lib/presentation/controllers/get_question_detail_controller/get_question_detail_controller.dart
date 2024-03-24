import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/application/di/question_detail/question_detail_query_service_provider.dart";
import "package:studyhub/application/question/application_service/get_question_detail_use_case.dart";
import "package:studyhub/application/question/application_service/question_detail_dto.dart";

import "../../../application/di/student/student_provider.dart";
import "../../../domain/question/models/question_id.dart";

part "get_question_detail_controller.g.dart";

@riverpod
class GetQuestionDetailController extends _$GetQuestionDetailController {
  @override
  Future<QuestionDetailDto> build(QuestionId questionId) async {
    final getQuestionDetailQueryService =
        ref.watch(getQuestionDetailQueryServiceDiProvider);
    final studentRepository = ref.watch(studentRepositoryDiProvider);

    final getQuestionDetailUseCase = GetQuestionDetailUseCase(
      queryService: getQuestionDetailQueryService,
      studentRepository: studentRepository,
    );

    final questionCardDto = getQuestionDetailUseCase.execute(questionId);
    return questionCardDto;
  }
}
