import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/components/parts/text_for_error.dart';

import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/user_detail_widget.dart';
import '../components/widgets/question_card_widget.dart';
import '../controllers/get_my_question_controller/get_my_question_controller.dart';
import '../controllers/student_controller/student_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';


class MyPage extends ConsumerWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.1;
    final studentState = ref.watch(studentControllerProvider);
    final myQuestionState = ref.watch(getMyQuestionControllerProvider);

    void pushToNotificationPage(BuildContext context) {
      context.push(PageId.notifications.path);
    }

    void pushToMenuPage(BuildContext context) {
      context.push(PageId.menu.path);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
            ),
            onPressed: () => pushToNotificationPage(context),
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
            ),
            onPressed: () => pushToMenuPage(context),
          ),
        ],
        backgroundColor: ColorSet.of(context).background,
      ),
      backgroundColor: ColorSet.of(context).background,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.only(
                            right: paddingHorizontal,
                            left: paddingHorizontal,
                            bottom: 20),
                        child: studentState.when(
                          data:(studentDto) => UserDetailWidget(
                            userName: studentDto.studentName,
                            numberOfFavoriteTeachers:
                                studentDto.,
                            userRank: studentDto.status.english,
                            numberOfQuestions: studentDto.questionCount,
                            userIconUrl: studentDto.profilePhotoPath,
                          ),
                          loading: () => const LoadingOverlay(),
                          error: (error, stackTrace){
                            return const Center(
                              child: Column(
                                children: [TextForError()],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    tabBar: TabBar(
                      indicatorColor: ColorSet.of(context).primary,
                      dividerColor: Colors.transparent,
                      labelColor: ColorSet.of(context).text,
                      unselectedLabelColor: ColorSet.of(context).unselectedText,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.header3),
                      unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.header3),
                      tabs: const [
                        Tab(text: L10n.myQuestionTabText),
                        Tab(text: L10n.bookmarkTabText),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              myQuestionState.when(
                data: (myQuestions) => myQuestions.isNotEmpty
                ? ListView.builder(
                    itemCount: myQuestions.length,
                    itemBuilder: (context, index) {
                      final myQuestion = myQuestions[index];
                      return Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      right: 20,
                      left: 20,
                    ),
                    child: QuestionCardWidget(
                        questionTitle: myQuestion.questionTitle,
                        question: myQuestion.questionText,
                        studentIconUrl: myQuestion.studentProfilePhotoPath,
                        teacherIconUrl: myQuestion.teacherProfilePhotoPath,
                        answer: myQuestion.answerText,
                        isBookmarked: myQuestion.isBookMarked),
                  );
                    },
                  )
                : const Center(
                    child: Text("質問がねえじゃん！"),
                  ),
                loading: () => const LoadingOverlay(),
            error: (error, stack) {
              print("エラーはこれです${error}");
              print(stack);
              return const Center(
                  child: Column(
                children: [
                  TextForError(),
                ],
              ),
              );
            },
                ),
            ])),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({
    required this.tabBar,
  });

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: ColorSet.of(context).background,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
