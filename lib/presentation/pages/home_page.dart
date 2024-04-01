import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/parts/text_for_error.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/get_my_bookmark_controller/get_my_bookmark_controller.dart';
import '../controllers/get_my_profile_controller/get_my_profile_controller.dart';
import '../controllers/get_my_question_controller/get_my_question_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMyProfileState = ref.watch(getMyProfileControllerProvider);
    final myQuestionState = ref.watch(getMyQuestionControllerProvider);
    final myBookmarksState = ref.watch(getMyBookmarksControllerProvider);

    useEffect(() {
      return null;
    }, [getMyProfileState]);

    void pushToSearchQuestionPage(BuildContext context) {
      context.push(PageId.searchQuestions.path);
    }

    final TabController _tabController = useTabController(initialLength: 5);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Text(
              L10n.titleText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                  color: ColorSet.of(context).text),
            ),
          ), //ここは画像に差し替え
        ),
        leadingWidth: 130,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: ColorSet.of(context).icon,
                size: FontSizeSet.getFontSize(context, 30),
              ),
              onPressed: () => pushToSearchQuestionPage(context)),
        ],
        backgroundColor: ColorSet.of(context).background,
        //高さ縮めたい（上下のデフォのpadding？縮めたい）、tab間の間隔縮めたい、colorSetに背景色として濃いグレー欲しいかも？（greySurfaceだとunselectedTextが見えづらい）
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorSet.of(context).greySurface),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorSet.of(context).primary,
                ),
                dividerColor: Colors.transparent,
                labelColor: ColorSet.of(context).text,
                unselectedLabelColor: ColorSet.of(context).unselectedText,
                labelStyle: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.getFontSize(
                    context,
                    FontSizeSet.body,
                  ),
                ),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                      context,
                      FontSizeSet.body,
                    )),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tab(
                      child: Text(
                        L10n.allTabText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).whiteText),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tab(
                      child: Text(
                        L10n.middleSchoolEnglishTabText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).whiteText),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tab(
                      child: Text(
                        L10n.middleSchoolMathTabText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).whiteText),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tab(
                      child: Text(
                        L10n.highSchoolEnglishTabText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).whiteText),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tab(
                      child: Text(
                        L10n.highSchoolMathTabText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).whiteText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: ColorSet.of(context).background,
        child: TabBarView(
          controller: _tabController,
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
                          color: ColorSet.of(context).text,
                        ),
                      ),
                    ),
              loading: () => const LoadingOverlay(),
              error: (error, stack) {
                return const Center(
                  child: TextForError(),
                );
              },
            ),
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
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            L10n.titleText,
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: ColorSet.of(context).text),
          ),
        ),
        leadingWidth: 130,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: ColorSet.of(context).icon,
                size: FontSizeSet.getFontSize(context, 30),
              ),
              onPressed: () => pushToSearchQuestionPage(context)),
        ],
        backgroundColor: ColorSet.of(context).background,
      ),
      backgroundColor: ColorSet.of(context).background,
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  tabBar: TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorSet.of(context).primary,
                    ),
                    dividerColor: Colors.transparent,
                    labelColor: ColorSet.of(context).text,
                    unselectedLabelColor: ColorSet.of(context).unselectedText,
                    labelStyle: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                        context,
                        FontSizeSet.body,
                      ),
                    ),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        )),
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Tab(child: Tab(text: L10n.allTabText)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Tab(text: L10n.middleSchoolEnglishTabText),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Tab(text: L10n.middleSchoolMathTabText),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Tab(text: L10n.highSchoolEnglishTabText),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Tab(text: L10n.highSchoolMathTabText),
                      ),
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
