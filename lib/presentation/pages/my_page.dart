import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/parts/text_for_error.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/user_detail_widget.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart';
import '../controllers/get_my_bookmark_controller/get_my_bookmark_controller.dart';
import '../controllers/get_my_profile_controller/get_my_profile_controller.dart';
import '../controllers/get_my_question_controller/get_my_question_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMyProfileState = ref.watch(getMyProfileControllerProvider);
    final favoriteTeacherState =
        ref.watch(getFavoriteTeacherControllerProvider);
    final myQuestionState = ref.watch(getMyQuestionControllerProvider);
    final myBookmarksState = ref.watch(getMyBookmarksControllerProvider);

    useEffect(() {
      return null;
    }, [getMyProfileState]);

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
              size: FontSizeSet.getFontSize(context, 30),
            ),
            onPressed: () => pushToNotificationPage(context),
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(context, 30),
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 20),
                      child: getMyProfileState.when(
                        data: (getMyProfileDto) {
                          final numberOfFavoriteTeachers =
                              favoriteTeacherState.maybeWhen(
                            data: (teachers) => teachers.length,
                            orElse: () => 0,
                          ); //ここはもっといい方法？があるはずではある
                          return UserDetailWidget(
                            userName: getMyProfileDto.studentName,
                            numberOfFavoriteTeachers: numberOfFavoriteTeachers,
                            userRank: getMyProfileDto.status.english,
                            numberOfQuestions: getMyProfileDto.questionCount,
                            userIconUrl: getMyProfileDto.profilePhotoPath,
                          );
                        },
                        loading: () => const LoadingOverlay(),
                        error: (error, stackTrace) {
                          return const Center(
                            child: TextForError(),
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
                    labelStyle: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                        context,
                        FontSizeSet.header3,
                      ),
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.header3,
                        )),
                    tabs: const [
                      Tab(text: L10n.myQuestionTabText),
                      Tab(text: L10n.bookmarkTabText),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
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
                            child: QuestionAndAnswerCardWidget(
                              questionCardDto: myQuestion,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "質問がありません",
                          style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header3),
                              color: ColorSet.of(context).text),
                        ),
                      ),
                loading: () => const LoadingOverlay(),
                error: (error, stack) {
                  return const Center(
                    child: TextForError(),
                  );
                },
              ),
              myBookmarksState.when(
                data: (myBookmarks) => myBookmarks.isNotEmpty
                    ? ListView.builder(
                        itemCount: myBookmarks.length,
                        itemBuilder: (context, index) {
                          final myBookmark = myBookmarks[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              right: 20,
                              left: 20,
                            ),
                            child: QuestionAndAnswerCardWidget(
                              questionCardDto: myBookmark,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "ブックマークがありません",
                          style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header3),
                              color: ColorSet.of(context).text),
                        ),
                      ),
                loading: () => const LoadingOverlay(),
                error: (error, stack) {
                  return const Center(
                    child: TextForError(),
                  );
                },
              ),
            ],
          ),
        ),
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
