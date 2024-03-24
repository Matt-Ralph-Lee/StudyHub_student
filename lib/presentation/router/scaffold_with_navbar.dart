import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        indicatorColor: ColorSet.of(context).navbarIndicator,
        surfaceTintColor: const Color(0x00000000),
        backgroundColor: ColorSet.of(context).background,
        destinations: const [
          // NavigationDestination(
          //   icon: Icon(Icons.home),
          //   label: 'Page1',
          // ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'questionPage',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "myPage",
          )
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
