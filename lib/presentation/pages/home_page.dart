import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/shared/subject.dart';
import '../components/widgets/question_card_list_widget.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final subjectLength = Subject.values.length + 1;
    final subjects = [
      null,
      Subject.midEng,
      Subject.midMath,
      Subject.highEng,
      Subject.highMath,
    ];

    String subjectToDisplayName(final Subject? subject) {
      switch (subject) {
        case null:
          return L10n.allTabText;
        case Subject.midEng:
          return L10n.middleSchoolEnglishTabText;
        case Subject.midMath:
          return L10n.middleSchoolMathTabText;
        case Subject.highEng:
          return L10n.highSchoolEnglishTabText;
        case Subject.highMath:
          return L10n.highSchoolMathTabText;
        default:
          throw Exception("invalid subject");
      }
    }

    void pushToSearchQuestionPage(BuildContext context) {
      context.push(PageId.searchQuestions.path);
    }

    final studyHubIcon = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image(
        image: const AssetImage("assets/icon/themeIcon.png"),
        width: FontSizeSet.getFontSize(
          context,
          30,
        ),
        fit: BoxFit.contain,
      ),
    );

    final studyHubTitle = Text(
      L10n.titleText,
      style: TextStyle(
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
          color: ColorSet.of(context).text),
    );

    final searchIcon = GestureDetector(
      child: Icon(
        Icons.search,
        color: ColorSet.of(context).icon,
        size: FontSizeSet.getFontSize(context, 30),
      ),
      onTap: () => pushToSearchQuestionPage(context),
    );

    return DefaultTabController(
      length: subjectLength,
      child: Scaffold(
        backgroundColor: ColorSet.of(context).background,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
                left: PaddingSet.getPaddingSize(
              context,
              20,
            )),
            child: GestureDetector(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  studyHubIcon,
                  const SizedBox(
                    width: 10,
                  ),
                  studyHubTitle,
                ],
              ),
            ), //ここは画像に差し替え
          ),
          leadingWidth: screenWidth < 600 ? 170 : 250,
          actions: [
            searchIcon,
            const SizedBox(
              width: 20,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              screenWidth < 600 ? 42 : 63,
            ),
            child: Container(
              height: screenWidth < 600 ? 42 : 63,
              margin: EdgeInsets.symmetric(
                  horizontal: PaddingSet.getPaddingSize(
                context,
                PaddingSet.horizontalPadding,
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorSet.of(context).greySurface),
              child: Padding(
                padding: EdgeInsets.all(PaddingSet.getPaddingSize(context, 3)),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  // controller: tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorSet.of(context).primary,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  padding: EdgeInsets.all(PaddingSet.getPaddingSize(
                    context,
                    2,
                  )),
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: PaddingSet.getPaddingSize(
                    context,
                    PaddingSet.horizontalPadding,
                  )),
                  labelStyle: TextStyle(
                    color: ColorSet.of(context).whiteText,
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                      context,
                      FontSizeSet.body,
                    ),
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: ColorSet.of(context).text,
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                      context,
                      FontSizeSet.body,
                    ),
                  ),
                  tabs: [
                    for (final subject in subjects)
                      Tab(text: subjectToDisplayName(subject))
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            for (final subject in subjects)
              QuestionCardListWidget(subject: subject)
          ],
        ),
      ),
    );
  }
}
