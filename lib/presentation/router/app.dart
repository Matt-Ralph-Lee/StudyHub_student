import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          secondary: Colors.transparent,
          onSecondary: Colors.transparent,
          error: Colors.transparent,
          onError: Colors.transparent,
          surface: Colors.transparent,
          onSurface: Colors.transparent,
        ), // colorScheme
      ), // ThemeData
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
