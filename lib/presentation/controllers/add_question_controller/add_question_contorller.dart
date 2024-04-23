import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../application/di/notification/factory/notification_factory_provider.dart";
import "../../../application/di/notification/repository/notification_repository_provider.dart";
import '../../../application/di/photo/repository/photo_repository_provider.dart';
import "../../../application/di/question/factory/question_factory_provider.dart";
import "../../../application/di/question/query_service/question_create_query_service.dart";
import "../../../application/di/question/repository/question_repository_provider.dart";
import "../../../application/di/session/session_provider.dart";
import "../../../application/di/student/student_provider.dart";
import "../../../application/question/application_service/question_create_use_case.dart";
import "../../../domain/shared/subject.dart";
import "../../../domain/teacher/models/teacher_id.dart";
import "../get_my_bookmark_controller/get_my_bookmark_controller.dart";
import "../get_my_profile_controller/get_my_profile_controller.dart";
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
      final questionQueryService =
          ref.read(questionCreateQueryServiceDiProvider);
      final photoRepository = ref.read(photoRepositoryDiProvider);
      final notificationFactory = ref.read(notificationFactoryDiProvider);
      final notificationRepository = ref.read(notificationRepositoryDiProvider);
      final studentRepository = ref.read(studentRepositoryDiProvider);
      final addQuestionUseCase = QuestionCreateUseCase(
        session: session,
        repository: questionRepository,
        factory: questionFactory,
        queryService: questionQueryService,
        photoRepository: photoRepository,
        notificationFactory: notificationFactory,
        notificationRepository: notificationRepository,
        studentRepository: studentRepository,
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
    ref.invalidate(getMyProfileControllerProvider);
  }
}
