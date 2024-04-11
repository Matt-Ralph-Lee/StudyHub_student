import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/show_create_question_page_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        height: screenWidth < 600 ? 50 : 75,
        // indicatorColor: ColorSet.of(context).navbarIndicator,
        surfaceTintColor: const Color(0x00000000),
        backgroundColor: ColorSet.of(context).background,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: ColorSet.of(context).greyText,
              size: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header1,
              ),
            ),
            selectedIcon: Icon(
              Icons.home,
              color: ColorSet.of(context).text,
              size: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header1,
              ),
            ),
            label: 'home',
          ),
          const NavigationDestination(
            icon: ShowCreateQuestionBottomSheet(),
            label: 'addQuestion',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: ColorSet.of(context).greyText,
              size: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header1,
              ),
            ),
            selectedIcon: Icon(
              Icons.person,
              color: ColorSet.of(context).text,
              size: FontSizeSet.getFontSize(
                context,
                FontSizeSet.header1,
              ),
            ),
            label: "myPage",
          )
        ],
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (index != 1) {
            navigationShell.goBranch(
              index,
              initialLocation:
                  index != navigationShell.currentIndex, // TODO: ここの挙動が謎だな
            );
          }
        },
      ),
    );
  }
}
