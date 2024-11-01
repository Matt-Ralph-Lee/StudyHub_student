import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:go_router/go_router.dart";

import "../../application/answer/application_service/answer_dto.dart";
import "../../application/di/interfaces/logger_provider.dart";
import "../../application/di/session/session_provider.dart";
import "../../application/di/student_auth/student_auth_provider.dart";
import "../../application/notification/application_service/get_my_notification_dto.dart";
import "../../application/question/application_service/question_detail_dto.dart";
import '../../application/student_auth/application_service/reload_user_use_case.dart';
import "../../domain/answer_list/models/answer_id.dart";
import "../../domain/question/models/question_id.dart";
import "../../domain/teacher/models/teacher_id.dart";
import "../pages/auth_page.dart";
import "../pages/blocking_teachers_page.dart";
import "../pages/check_answer_image_page.dart";
import "../pages/check_question_image_page.dart";
import "../pages/create_question_page.dart";
import "../pages/evaluation_page.dart";
import '../pages/favorite_teachers_page.dart';
import "../pages/edit_profile_page.dart";
import "../pages/menu_page.dart";
import "../pages/notification_detail_page.dart";
import "../pages/notification_page.dart";
import "../pages/profile_input_page.dart";
import "../pages/question_and_answer_page.dart";
import "../pages/report_page.dart";
import "../pages/resend_email_verification_page.dart";
import "../pages/reset_password_page.dart";
import "../pages/search_for_questions_page.dart";
import "../pages/search_for_teachers_page.dart";
import "../pages/my_page.dart";
import "../pages/home_page.dart";
import "../pages/select_teachers_page.dart";
import "../pages/teacher_profile_page.dart";
import '../shared/utils/accessibility.dart';
import "scaffold_with_navbar.dart";
import '../shared/constants/page_path.dart';

part "router.g.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _page1NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _page2NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'addQuestion');
final _page3NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'myPage');

@riverpod
GoRouter router(Ref ref) {
  final routes = [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageId.home.path,
              name: PageId.home.name,
              builder: (context, state) => const HomePage(),
            )
          ],
          navigatorKey: _page1NavigatorKey,
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageId.addQuestion.path,
              name: PageId.addQuestion.name,
              builder: (context, state) => const CreateQuestionPage(),
            )
          ],
          navigatorKey: _page2NavigatorKey,
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageId.myPage.path,
              name: PageId.myPage.name,
              builder: (context, state) => const MyPage(),
            ),
          ],
          navigatorKey: _page3NavigatorKey,
        ),
      ],
    ),
    GoRoute(
      path: PageId.profileInput.path,
      name: PageId.profileInput.name,
      builder: (context, state) => const ProfileInputPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: PageId.menu.path,
      name: PageId.menu.name,
      builder: (context, state) => const MenuPage(),
    ),
    GoRoute(
      path: PageId.searchTeachers.path,
      name: PageId.searchTeachers.name,
      builder: (context, state) => const SearchForTeachersPage(),
    ),
    GoRoute(
      path: PageId.favoriteTeachers.path,
      name: PageId.favoriteTeachers.name,
      builder: (context, state) => const FavoriteTeachersPage(),
    ),
    GoRoute(
      path: PageId.notifications.path,
      name: PageId.notifications.name,
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: PageId.editProfile.path,
      name: PageId.editProfile.name,
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: PageId.evaluationPage.path,
      name: PageId.evaluationPage.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final teacherId = args[0] as TeacherId;
        final answerId = args[1] as AnswerId;
        final questionId = args[2] as QuestionId;
        return EvaluationPage(
          fromAnswer: answerId,
          fromQuestion: questionId,
          teacherId: teacherId,
        ); //引数渡す際はこれでいいかね？
      },
    ),
    GoRoute(
      path: PageId.selectTeachers.path,
      name: PageId.selectTeachers.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final Function(TeacherId) onPressed = args[0] as Function(TeacherId);
        final selectedTeachers = args[1] as ValueNotifier<List<TeacherId>>;
        return SelectTeachersPage(
          onPressed: onPressed,
          selectedTeachers: selectedTeachers,
        ); //引数渡す際はこれでいいかね？
      },
    ),
    GoRoute(
      path: PageId.teacherProfile.path,
      name: PageId.teacherProfile.name,
      builder: (context, state) {
        final teacherId = state.extra as TeacherId;
        return TeacherProfilePage(
          teacherId: teacherId,
        );
      },
    ),
    GoRoute(
      path: PageId.questionAndAnswerPage.path,
      name: PageId.questionAndAnswerPage.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final QuestionId questionId = args[0] as QuestionId;
        final bool isMyQuestion = args[1] as bool;
        final AnswerId? additionalArg =
            args.length > 2 ? args[2] as AnswerId? : null;
        return QuestionAndAnswerPage(
          questionId: questionId,
          isMyQuestion: isMyQuestion,
          answerId: additionalArg,
        );
      },
    ),
    GoRoute(
      path: PageId.searchQuestions.path,
      name: PageId.searchQuestions.name,
      builder: (context, state) => const SearchForQuestionsPage(),
    ),
    GoRoute(
      path: PageId.reportQuestionPage.path,
      name: PageId.reportQuestionPage.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final QuestionId? questionId = args[0] as QuestionId?;
        final TeacherId? teacherId = args[1] as TeacherId?;
        return ReportPage(
          questionId: questionId,
          teacherId: teacherId,
        );
      },
    ),
    GoRoute(
      path: PageId.checkQuestionImagePage.path,
      name: PageId.checkQuestionImagePage.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final QuestionDetailDto questionDetailDto =
            args[0] as QuestionDetailDto;
        final int order = args[1] as int;
        return CheckQuestionImagePage(
          questionDetailDto: questionDetailDto,
          order: order,
        );
      },
    ),
    GoRoute(
      path: PageId.checkAnswerImagePage.path,
      name: PageId.checkAnswerImagePage.name,
      builder: (context, state) {
        final List<dynamic> args = state.extra as List<dynamic>;
        final AnswerDto answerDto = args[0] as AnswerDto;
        final int order = args[1] as int;
        return CheckAnswerImagePage(
          answerDto: answerDto,
          order: order,
        );
      },
    ),
    GoRoute(
      path: PageId.notificationDetailPage.path,
      name: PageId.notificationDetailPage.name,
      builder: (context, state) {
        final getMyNotificationDto = state.extra as GetMyNotificationDto;
        return NotificationDetailPage(
          getMyNotificationDto: getMyNotificationDto,
        );
      },
    ),
    GoRoute(
      path: PageId.authPage.path,
      name: PageId.authPage.name,
      builder: (context, state) => const AuthPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: PageId.emailVerificationPage.path,
      name: PageId.emailVerificationPage.name,
      builder: (context, state) {
        final session = ref.read(sessionDiProvider);
        final emailAddress = session?.emailAddress.value;
        return ResendEmailVerificationPage(
          emailAddress: emailAddress!,
        );
      },
    ),
    GoRoute(
      path: PageId.resetPassword.path,
      name: PageId.resetPassword.name,
      builder: (context, state) => const ResetPasswordPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: PageId.blockingTeacherPage.path,
      name: PageId.blockingTeacherPage.name,
      builder: (context, state) => const BlockingTeachersPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
  ];

  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final pagePath = state.uri.toString();
    var isSignedInState = ref.read(isSignedInProvider);

    if (!isSignedInState) {
      final studentAuthRepository = ref.read(studentAuthRepositoryDiProvider);
      final logger = ref.read(loggerDiProvider);
      final reloadUser = ReloadUserUseCase(
        repository: studentAuthRepository,
        logger: logger,
      );
      await reloadUser.execute();
      isSignedInState = ref.read(isSignedInProvider);
    }

    final isVerifiedState = ref.read(isVerifiedProvider);

    if (isSignedInState && !isVerifiedState && isPrivate(pagePath)) {
      return PageId.emailVerificationPage.path;
    }

    if (!isSignedInState && isPrivate(pagePath)) {
      return PageId.authPage.path;
    }

    return null;
  }

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: PageId.home.path,
    debugLogDiagnostics: false,
    routes: routes,
    redirect: redirect,
  );
}
