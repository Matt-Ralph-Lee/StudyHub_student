import 'package:flutter/material.dart';
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:go_router/go_router.dart";
import "package:studyhub/presentation/auth/tmp.dart";
import "package:studyhub/presentation/pages/login_page.dart";
import "package:studyhub/presentation/pages/page1.dart";
import "package:studyhub/presentation/pages/page2.dart";
import "package:studyhub/presentation/pages/page3.dart";

import "scaffold_with_navbar.dart";
import "page_path.dart";

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
            )
          ],
          navigatorKey: _page3NavigatorKey,
        ),
      ],
    ),
    GoRoute(
      path: PageId.login.path,
      name: PageId.login.name,
      builder: (context, state) => const LoginPage(),
      parentNavigatorKey: _rootNavigatorKey,
    ),
  ];

  String? redirect(BuildContext context, GoRouterState state) {
    final page = state.uri.toString();
    final isLoggedIn = ref.read(tmpProvider);

    if (isLoggedIn && page == PageId.login.path) {
      return PageId.page1.path;
    } else if (!isLoggedIn && page != PageId.login.path) {
      return PageId.login.path;
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
