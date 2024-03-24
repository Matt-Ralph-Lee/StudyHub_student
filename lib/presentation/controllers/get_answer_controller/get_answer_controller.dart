import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/answer/application_service/answer_dto.dart";
import "../../../application/answer/application_service/get_answer_use_case.dart";
import "../../../application/di/answer/query_service/answer_query_service_provider.dart";
import "../../../domain/question/models/question_id.dart";

part "get_answer_controller.g.dart";

@riverpod
class GetAnswerController extends _$GetAnswerController {
  @override
  Future<List<AnswerDto>> build(QuestionId questionId) async {
    final getAnswerQueryService = ref.watch(getAnswerQueryServiceDiProvider);

    final answerUseCase = GetAnswerUseCase(getAnswerQueryService);

    final questionCardDto = answerUseCase.execute(questionId);
    return questionCardDto;
  }
}
