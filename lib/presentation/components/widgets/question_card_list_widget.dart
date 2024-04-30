import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/shared/subject.dart';
import '../../controllers/get_recommended_quesiotns_controller/get_recommended_questions_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/padding_set.dart';
import '../parts/text_for_error.dart';
import '../parts/text_for_no_question_found.dart';
import 'question_and_answer_card_skeleton_widget.dart';
import 'question_and_answer_card_widget.dart';

class QuestionCardListWidget extends StatefulHookConsumerWidget {
  const QuestionCardListWidget({super.key, required this.subject});

  final Subject? subject;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionCardListWidget();
}

class _QuestionCardListWidget extends ConsumerState<QuestionCardListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final getRecommendedQuestionsState =
        ref.watch(getRecommendedQuestionsControllerProvider(widget.subject));

    return getRecommendedQuestionsState.when(
      data: (recommendedQuestions) => recommendedQuestions.isNotEmpty
          ? RefreshIndicator(
              backgroundColor: ColorSet.of(context).primary,
              color: ColorSet.of(context).whiteText,
              onRefresh: () async {
                ref.invalidate(
                    getRecommendedQuestionsControllerProvider(widget.subject));
              },
              child: ListView.builder(
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
              ),
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
      skipLoadingOnRefresh: false, // refreshしたときにshimmer effectを追加。
    );
  }

  @override
  bool get wantKeepAlive => true;
}
