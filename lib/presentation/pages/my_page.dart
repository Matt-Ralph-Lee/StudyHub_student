import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/widgets/user_detail_widget.dart';
import '../components/widgets/question_card_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';

//生徒のDto的なもの
class StudentDto {
  final String userName;
  final String userIconUrl;
  final String numberOfFavoriteTeachers;
  final String userRank;
  final int numberOfQuestions;
  const StudentDto({
    required this.userName,
    required this.userIconUrl,
    required this.numberOfFavoriteTeachers,
    required this.userRank,
    required this.numberOfQuestions,
  });
}

//質問&回答のDto的なもの。とりまセットにしてある
class QuestionDto {
  final String questionTitle;
  final String question;
  final String studentIconUrl;
  final String answer;
  final String teacherIconUrl;
  final bool isBookMarked;
  const QuestionDto({
    required this.questionTitle,
    required this.question,
    required this.studentIconUrl,
    required this.answer,
    required this.teacherIconUrl,
    required this.isBookMarked,
  });
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingHorizontal = screenWidth * 0.1;

    //authenticatedUser
    final studentDto = StudentDto(
        userName: "もりわきかずはる",
        userIconUrl: "アイコンurl",
        numberOfFavoriteTeachers: "1",
        userRank: "beginner",
        numberOfQuestions: 10);

    //↑のMyQuestions
    const List<QuestionDto> myQuestions = [
      QuestionDto(
          questionTitle: "質問1",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問2",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: false),
      QuestionDto(
          questionTitle: "質問3",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問4",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問4",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問4",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
    ];
    //↑のBookMarks
    const List<QuestionDto> bookMarks = [
      QuestionDto(
          questionTitle: "質問1",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問2",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問3",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
      QuestionDto(
          questionTitle: "質問4",
          question:
              "質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です質問です",
          studentIconUrl: "生徒のアイコンurl",
          answer:
              "回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です回答です",
          teacherIconUrl: "先生のアイコンurl",
          isBookMarked: true),
    ];

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
                        child: UserDetailWidget(
                          userName: studentDto.userName,
                          numberOfFavoriteTeachers:
                              studentDto.numberOfFavoriteTeachers,
                          userRank: studentDto.userRank,
                          numberOfQuestions: studentDto.numberOfQuestions,
                          userIconUrl: studentDto.userIconUrl,
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
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
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
                        question: myQuestion.question,
                        studentIconUrl: myQuestion.studentIconUrl,
                        teacherIconUrl: myQuestion.teacherIconUrl,
                        answer: myQuestion.answer,
                        isBookmarked: myQuestion.isBookMarked),
                  );
                },
              ),
              ListView.builder(
                itemCount: bookMarks.length,
                itemBuilder: (context, index) {
                  final bookMarkedQuestion = bookMarks[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: QuestionCardWidget(
                        questionTitle: bookMarkedQuestion.questionTitle,
                        question: bookMarkedQuestion.question,
                        studentIconUrl: bookMarkedQuestion.studentIconUrl,
                        teacherIconUrl: bookMarkedQuestion.teacherIconUrl,
                        answer: bookMarkedQuestion.answer,
                        isBookmarked: bookMarkedQuestion.isBookMarked),
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
