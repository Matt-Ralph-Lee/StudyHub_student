import "package:riverpod_annotation/riverpod_annotation.dart";

import '../../../application/di/photo/repository/photo_repository_provider.dart';
import "../../../application/di/question/factory/question_factory_provider.dart";
import "../../../application/di/question/repository/question_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/question/application_service/question_create_use_case.dart";
import "../../../domain/shared/subject.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_my_bookmark_controller/get_my_bookmark_controller.dart";
import "../get_my_question_controller/get_my_question_controller.dart";
import "../get_recommended_quesiotns_controller/get_recommended_questions_controller.dart";

part "add_question_contorller.g.dart";

@riverpod
class AddQuestionController extends _$AddQuestionController {
  @override
  Future<void> build() async {}

  Future<void> addQuestion(
    String questionTitle,
    String question,
    Subject subject,
    List<String> photos,
    List<TeacherId> selectedTeachersId,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = ref.read(nonNullSessionProvider);
      final questionRepository = ref.read(questionRepositoryDiProvider);
      final questionFactory = ref.read(questionFactoryDiProvider);
      final photoRepository = ref.read(photoRepositoryDiProvider);
      final addQuestionUseCase = QuestionCreateUseCase(
        session: session,
        repository: questionRepository,
        factory: questionFactory,
        photoRepository: photoRepository,
      );
      await addQuestionUseCase.execute(
        questionTitleData: questionTitle,
        questionTextData: question,
        localPathList: photos,
        questionSubject: subject,
        selectedTeacherListData: selectedTeachersId,
      );
    });
    ref.invalidate(getMyQuestionControllerProvider);
    ref.invalidate(getMyBookmarksControllerProvider);
    ref.invalidate(getRecommendedQuestionsControllerProvider);
  }
}
