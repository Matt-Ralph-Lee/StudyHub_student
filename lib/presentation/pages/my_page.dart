import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/parts/text_for_error.dart';
import '../components/widgets/question_and_answer_card_skeleton_widget.dart';
import '../components/widgets/user_detail_skeleton_widget.dart';
import '../components/widgets/user_detail_widget.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/check_notification_controller/check_notification_controller.dart';
import '../controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart';
import '../controllers/get_my_bookmark_controller/get_my_bookmark_controller.dart';
import '../controllers/get_my_profile_controller/get_my_profile_controller.dart';
import '../controllers/get_my_question_controller/get_my_question_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkNotificationState =
        ref.watch(checkNotificationControllerProvider);
    final getMyProfileState = ref.watch(getMyProfileControllerProvider);
    final favoriteTeacherState =
        ref.watch(getFavoriteTeacherControllerProvider);
    final myQuestionState = ref.watch(getMyQuestionControllerProvider);
    final myBookmarksState = ref.watch(getMyBookmarksControllerProvider);

    void pushToNotificationPage(BuildContext context) {
      context.push(PageId.notifications.path);
    }

    void pushToMenuPage(BuildContext context) {
      context.push(PageId.menu.path);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          checkNotificationState.when(
            data: (notificationExist) {
              return notificationExist
                  ? Stack(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.notifications_none,
                            color: ColorSet.of(context).icon,
                            size: FontSizeSet.getFontSize(context, 30),
                          ),
                          onTap: () => pushToNotificationPage(context),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Icon(
                              Icons.circle,
                              color: ColorSet.of(context)
                                  .errorText
                                  .withOpacity(0.9),
                              size: 10,
                            )),
                      ],
                    )
                  : GestureDetector(
                      child: Icon(
                        Icons.notifications_none,
                        color: ColorSet.of(context).icon,
                        size: FontSizeSet.getFontSize(context, 30),
                      ),
                      onTap: () => pushToNotificationPage(context),
                    );
            },
            loading: () => Icon(
              Icons.notifications_none,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(context, 30),
            ),
            error: (error, stackTrace) {
              return const Center(
                child: TextForError(),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Icon(
              Icons.menu,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(context, 30),
            ),
            onTap: () => pushToMenuPage(context),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: ColorSet.of(context).background,
      ),
      backgroundColor: ColorSet.of(context).background,
      body: DefaultTabController(
        length: 2,
        child: RefreshIndicator(
          notificationPredicate: (notification) => notification.depth == 2,
          backgroundColor: ColorSet.of(context).primary,
          color: ColorSet.of(context).whiteText,
          onRefresh: () async {
            HapticFeedback.lightImpact();
            ref.invalidate(getMyQuestionControllerProvider);
            ref.invalidate(getMyBookmarksControllerProvider);
            ref.invalidate(checkNotificationControllerProvider);
            ref.invalidate(getMyProfileControllerProvider);
            ref.invalidate(getFavoriteTeacherControllerProvider);
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: getMyProfileState.when(
                          data: (getMyProfileDto) {
                            final numberOfFavoriteTeachers =
                                favoriteTeacherState.maybeWhen(
                              data: (teachers) => teachers.length,
                              orElse: () => 0,
                            ); //ここはもっといい方法？があるはずではある
                            return UserDetailWidget(
                              userName: getMyProfileDto.studentName,
                              numberOfFavoriteTeachers:
                                  numberOfFavoriteTeachers,
                              userRank: getMyProfileDto.status.english,
                              numberOfQuestions: getMyProfileDto.questionCount,
                              userIconUrl: getMyProfileDto.profilePhotoPath,
                            );
                          },
                          loading: () => const UserDetailSkeletonWidget(),
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
                  data: (myQuestions) => ListView.builder(
                    itemCount: myQuestions.isNotEmpty ? myQuestions.length : 1,
                    itemBuilder: (context, index) {
                      if (myQuestions.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                              PaddingSet.getPaddingSize(
                                context,
                                PaddingSet.horizontalPadding,
                              ),
                            ),
                            child: Text(
                              L10n.noQuestionsFound,
                              style: TextStyle(
                                fontWeight: FontWeightSet.normal,
                                fontSize: FontSizeSet.getFontSize(
                                    context, FontSizeSet.header3),
                                color: ColorSet.of(context).text,
                              ),
                            ),
                          ),
                        );
                      }
                      final myQuestion = myQuestions[index];
                      return Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: QuestionAndAnswerCardWidget(
                          questionCardDto: myQuestion,
                        ),
                      );
                    },
                  ),
                  loading: () => ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: const QuestionAndAnswerCardSkeletonWidget(),
                      );
                    },
                  ),
                  error: (error, stack) => ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.horizontalPadding,
                            ),
                          ),
                          child: const TextForError(),
                        ),
                      ),
                    ],
                  ),
                ),
                myBookmarksState.when(
                  data: (myBookmarks) => ListView.builder(
                    itemCount: myBookmarks.isNotEmpty ? myBookmarks.length : 1,
                    itemBuilder: (context, index) {
                      if (myBookmarks.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: PaddingSet.getPaddingSize(
                                context,
                                50,
                              ),
                            ),
                            child: Text(
                              L10n.noBookmarksFound,
                              style: TextStyle(
                                  fontWeight: FontWeightSet.normal,
                                  fontSize: FontSizeSet.getFontSize(
                                      context, FontSizeSet.header3),
                                  color: ColorSet.of(context).text),
                            ),
                          ),
                        );
                      }
                      final myBookmark = myBookmarks[index];
                      return Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: QuestionAndAnswerCardWidget(
                          questionCardDto: myBookmark,
                        ),
                      );
                    },
                  ),
                  loading: () => ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.horizontalPadding,
                          ),
                        ),
                        child: const QuestionAndAnswerCardSkeletonWidget(),
                      ),
                    ],
                  ),
                  error: (error, stack) => ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.horizontalPadding,
                            ),
                          ),
                          child: const TextForError(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
