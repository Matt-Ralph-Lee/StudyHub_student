import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final searchTeachersController = useTextEditingController();
    final searchTerm = useState<String>("");

    final searchQuestionState =
        ref.watch(searchQuestionsControllerProvider(searchTerm.value));

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
              title: TextFormFieldForSearchForTeachers(
                controller: searchTeachersController,
                onSearched: setSearchTerm,
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
