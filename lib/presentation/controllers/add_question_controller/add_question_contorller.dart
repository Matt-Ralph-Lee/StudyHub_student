import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:studyhub/application/di/photo/photo_repository_provider.dart";
import "package:studyhub/application/question/application_service/question_create_use_case.dart";
import "package:studyhub/domain/teacher/models/teacher_id.dart";

import "../../../application/di/question/factory/question_factory_provider.dart";
import "../../../application/di/question/repository/question_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../domain/shared/subject.dart";

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
  }
}
