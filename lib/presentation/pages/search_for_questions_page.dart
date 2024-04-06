import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/shared/subject.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_form_field_for_search_teachers.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/question_and_answer_card_widget.dart';
import '../controllers/search_questions_controller/serach_questions_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class SearchForQuestionsPage extends HookConsumerWidget {
  const SearchForQuestionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / 5;
    final searchTeachersController = useTextEditingController();
    final searchTerm = useState<String>("");
    final selectedSubject = useState<Subject?>(null);
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

    final searchQuestionState = ref.watch(searchQuestionsControllerProvider(
        searchTerm.value, selectedSubject.value));

    void setSearchTerm(String text) {
      searchTerm.value = text;
    }

    return Scaffold(
        backgroundColor: ColorSet.of(context).background,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: ColorSet.of(context).icon,
                  size: FontSizeSet.getFontSize(
                    context,
                    30,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: ColorSet.of(context).background,
              pinned: false,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ), //スマホにおいてタブの右端と合わせるため.タブレットはきりがないので妥協
                child: TextFormFieldForSearchForTeachers(
                  controller: searchTeachersController,
                  onSearched: setSearchTerm,
                ),
              ),
              // actions: [
              //   Container(
              //     width: screenWidth < 350? 300:screenWidth < 600? ,
              //     margin: EdgeInsets.only(
              //         right: PaddingSet.getPaddingSize(context, 20)),
              //     child: TextFormFieldForSearchForTeachers(
              //       controller: searchTeachersController,
              //       onSearched: setSearchTerm,
              //     ),
              //   ),
              // ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                  screenWidth < 600 ? 42 : 63,
                ),
                child: Container(
                  height: screenWidth < 600 ? 42 : 63,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorSet.of(context).greySurface),
                  child: Padding(
                    padding:
                        EdgeInsets.all(PaddingSet.getPaddingSize(context, 3)),
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
                        20,
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
            if (searchTerm.value.isEmpty) ...[
              SliverFillRemaining(
                child: Center(
                  child: Text(L10n.noQuestionsFound,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                          color: ColorSet.of(context).text)),
                ),
              ),
            ] else ...[
              SliverPadding(
                padding: EdgeInsets.only(
                    top: 30,
                    right: PaddingSet.getPaddingSize(context, 24),
                    left: PaddingSet.getPaddingSize(context, 24)),
                sliver: searchQuestionState.when(
                  data: (questionsDto) => questionsDto != null &&
                          questionsDto.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final questionDto = questionsDto[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: QuestionAndAnswerCardWidget(
                                      questionCardDto: questionDto,
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: questionsDto.length,
                          ),
                        )
                      : SliverFillRemaining(
                          child: Center(
                            child: Text(L10n.noQuestionsFound,
                                style: TextStyle(
                                    fontWeight: FontWeightSet.normal,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.header3),
                                    color: ColorSet.of(context).text)),
                          ),
                        ),
                  loading: () =>
                      const SliverToBoxAdapter(child: LoadingOverlay()),
                  error: (error, stack) {
                    return const SliverFillRemaining(
                      child: Center(child: TextForError()),
                    );
                  },
                ),
              ),
            ]
          ],
        ));
  }
}
