import 'package:flutter/material.dart';
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:go_router/go_router.dart";
import "package:studyhub/presentation/pages/report_page.dart";

import "../../application/di/session/session_provider.dart";
import "../../domain/answer_list/models/answer_id.dart";
import "../../domain/question/models/question_id.dart";
import "../../domain/teacher/models/teacher_id.dart";
import "../pages/auth_page.dart";
import "../pages/create_question_page.dart";
import "../pages/evaluation_page.dart";
import '../pages/favorite_teachers_page.dart';
import "../pages/edit_profile_page.dart";
import "../pages/menu_page.dart";
import "../pages/notification_page.dart";
import "../pages/profile_input_page.dart";
import "../pages/question_and_answer_page.dart";
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
GoRouter router(RouterRef ref) {
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
      path: PageId.authPage.path,
      name: PageId.authPage.name,
      builder: (context, state) => const AuthPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
    GoRoute(
      path: PageId.resetPassword.path,
      name: PageId.resetPassword.name,
      builder: (context, state) => const ResetPasswordPage(),
      parentNavigatorKey: _rootNavigatorKey,
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
        return QuestionAndAnswerPage(
          questionId: questionId,
          isMyQuestion: isMyQuestion,
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
  ];

  String? redirect(BuildContext context, GoRouterState state) {
    final pagePath = state.uri.toString();
    final isSignedIn = ref.read(isSignedInProvider);
    if (isSignedIn && requiresLoggedOut(pagePath)) {
      return PageId.page1.path;
    } else if (!isSignedIn && isPrivate(pagePath)) {
      return PageId.authPage.path;
    } else {
      return null;
    }
  }

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: PageId.page1.path,
    debugLogDiagnostics: false,
    routes: routes,
    redirect: redirect,
  );
}
