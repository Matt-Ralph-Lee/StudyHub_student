import 'package:flutter/material.dart';
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:go_router/go_router.dart";
import "package:studyhub/presentation/auth/tmp.dart";
import "package:studyhub/presentation/pages/notification_page.dart";
import "package:studyhub/presentation/pages/page1.dart";
import "package:studyhub/presentation/pages/page2.dart";
import "package:studyhub/presentation/pages/page3.dart";
import "package:studyhub/presentation/pages/profile_input_page.dart";

import "../pages/auth_page.dart";
import "../pages/menu_page.dart";
import "../pages/reset_password_page.dart";
import "../pages/search_teachers_page.dart";
import '../shared/utils/accessibility.dart';
import "scaffold_with_navbar.dart";
import '../shared/constants/page_path.dart';

part "router.g.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _page1NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'page1');
final _page2NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'page2');
final _page3NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'page3');

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
              path: PageId.page1.path,
              name: PageId.page1.name,
              builder: (context, state) => const Page1(),
            )
          ],
          navigatorKey: _page1NavigatorKey,
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageId.page2.path,
              name: PageId.page2.name,
              builder: (context, state) => const Page2(),
            )
          ],
          navigatorKey: _page2NavigatorKey,
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageId.page3.path,
              name: PageId.page3.name,
              builder: (context, state) => const Page3(),
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
      builder: (context, state) => const SearchTeachersPage(),
    ),
    GoRoute(
      path: PageId.notifications.path,
      name: PageId.notifications.name,
      builder: (context, state) => const NotificationPage(),
    ),
  ];

  String? redirect(BuildContext context, GoRouterState state) {
    final pagePath = state.uri.toString();
    final isLoggedIn = ref.read(tmpProvider);

    if (isLoggedIn && requiresLoggedOut(pagePath)) {
      return PageId.page1.path;
    } else if (!isLoggedIn && isPrivate(pagePath)) {
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
