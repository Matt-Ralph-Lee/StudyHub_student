import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/shared/subject.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_question_found.dart';
import '../components/widgets/question_and_answer_card_skeleton_widget.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/get_recommended_quesiotns_controller/get_recommended_questions_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
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
    }, []);

    void pushToSearchQuestionPage(BuildContext context) {
      context.push(PageId.searchQuestions.path);
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(
              left: PaddingSet.getPaddingSize(
            context,
            20,
          )),
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
        leadingWidth: screenWidth < 600 ? 130 : 200,
        actions: [
          GestureDetector(
              child: Icon(
                Icons.search,
                color: ColorSet.of(context).icon,
                size: FontSizeSet.getFontSize(context, 30),
              ),
              onTap: () => pushToSearchQuestionPage(context)),
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
                controller: tabController,
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
                tabs: const [
                  Tab(
                    text: L10n.allTabText,
                  ),
                  Tab(
                    text: L10n.middleSchoolEnglishTabText,
                  ),
                  Tab(
                    text: L10n.middleSchoolMathTabText,
                  ),
                  Tab(
                    text: L10n.highSchoolEnglishTabText,
                  ),
                  Tab(
                    text: L10n.highSchoolMathTabText,
                  )
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
                    padding: EdgeInsets.only(
                      top: PaddingSet.getPaddingSize(
                        context,
                        30,
                      ),
                      right: PaddingSet.getPaddingSize(
                        context,
                        20,
                      ),
                      left: PaddingSet.getPaddingSize(
                        context,
                        20,
                      ),
                      bottom: index == recommendedQuestions.length - 1
                          ? PaddingSet.getPaddingSize(
                              context,
                              20,
                            )
                          : 0,
                    ),
                    child: QuestionAndAnswerCardWidget(
                      questionCardDto: recommendedQuestion,
                    ),
                  );
                },
              )
            : const Center(
                child: TextForNoQuestionFound(),
              ),
        loading: () => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: PaddingSet.getPaddingSize(
                    context,
                    30,
                  ),
                  right: PaddingSet.getPaddingSize(
                    context,
                    20,
                  ),
                  left: PaddingSet.getPaddingSize(
                    context,
                    20,
                  )),
              child: const QuestionAndAnswerCardSkeletonWidget(),
            );
          },
        ),
        error: (error, stack) {
          return const Center(
            child: TextForError(),
          );
        },
      ),
    );
  }
}
