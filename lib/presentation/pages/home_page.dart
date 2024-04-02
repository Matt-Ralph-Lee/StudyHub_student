import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/shared/subject.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/get_recommended_quesiotns_controller/get_recommended_questions_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/page_path.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubject = useState<Subject?>(null);
    final getRecommendedQuestionsState = ref.watch(
        getRecommendedQuestionsControllerProvider(selectedSubject.value));

    final TabController tabController = useTabController(initialLength: 5);
    useEffect(() {
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          switch (tabController.index) {
            case 0:
              selectedSubject.value = null;
              break;
            case 1:
              selectedSubject.value = Subject.midEng;
              break;
            case 2:
              selectedSubject.value = Subject.midMath;
              break;
            case 3:
              selectedSubject.value = Subject.highEng;
              break;
            case 4:
              selectedSubject.value = Subject.highMath;
              break;
          }
        }
      });
      return () => tabController.removeListener(() {});
    }, [tabController]);

    void pushToSearchQuestionPage(BuildContext context) {
      context.push(PageId.searchQuestions.path);
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
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
                controller: tabController,
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
      body: getRecommendedQuestionsState.when(
        data: (recommendedQuestions) => recommendedQuestions.isNotEmpty
            ? ListView.builder(
                itemCount: recommendedQuestions.length,
                itemBuilder: (context, index) {
                  final recommendedQuestion = recommendedQuestions[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: QuestionAndAnswerCardWidget(
                      questionCardDto: recommendedQuestion,
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "質問がありません",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.normal, // FontWeightSet.normalに適宜調整してください
                    fontSize: 20, // FontSizeSet.getFontSizeに適宜調整してください
                    color: Colors.black, // ColorSet.of(context).textに適宜調整してください
                  ),
                ),
              ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => const Center(
          child: Text('エラーが発生しました'),
        ),
      ),
      // body: Container(
      //   color: ColorSet.of(context).background,
      //   child: TabBarView(
      //     controller: tabController,
      //     //キモいけどこうするしかない？よね？もしくはtab使わないでカスタムウィジェットを作るか？
      //     children: [
      //       RecommendedQuestionsWidgets(
      //         getRecommendedQuestionsState: getRecommendedQuestionsState,
      //       ),
      //       RecommendedQuestionsWidgets(
      //         getRecommendedQuestionsState: getRecommendedQuestionsState,
      //       ),
      //       RecommendedQuestionsWidgets(
      //         getRecommendedQuestionsState: getRecommendedQuestionsState,
      //       ),
      //       RecommendedQuestionsWidgets(
      //         getRecommendedQuestionsState: getRecommendedQuestionsState,
      //       ),
      //       RecommendedQuestionsWidgets(
      //         getRecommendedQuestionsState: getRecommendedQuestionsState,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
