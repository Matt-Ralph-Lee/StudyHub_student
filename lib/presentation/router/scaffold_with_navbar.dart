import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

import '../components/widgets/show_create_question_page_widget.dart';

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
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: ColorSet.of(context).text,
            ),
            label: 'myPage',
          ),
          const NavigationDestination(
            icon: ShowCreateQuestionBottomSheet(),
            label: 'addQuestion',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: ColorSet.of(context).text,
            ),
            label: "evaluationPage",
          )
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (index != 1) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          }
        },
      ),
    );
  }
}
