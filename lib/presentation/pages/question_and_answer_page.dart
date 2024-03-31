import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/question/models/question_id.dart';
import '../components/parts/text_button_for_navigating_to_evaluatin_page.dart';
import '../components/parts/text_for_error.dart';
import '../components/widgets/answer_card_widget.dart';
import '../components/widgets/answer_picture_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/question_detail_card_widget.dart';
import '../components/widgets/question_pictures_widget.dart';
import '../controllers/get_answer_controller/get_answer_controller.dart';
import '../controllers/get_question_detail_controller/get_question_detail_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class QuestionAndAnswerPage extends HookConsumerWidget {
  final QuestionId questionId;
  final bool isMyQuestion;
  const QuestionAndAnswerPage({
    super.key,
    required this.questionId,
    required this.isMyQuestion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getQuestionDetailControllerState =
        ref.watch(getQuestionDetailControllerProvider(questionId));
    final getAnswerControllerState =
        ref.watch(getAnswerControllerProvider(questionId));

    final selectedAnswerIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          L10n.questionAndAnswerPageTitleText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            getQuestionDetailControllerState.when(
              data: (questionDetailDto) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: QuestionDetailCardWidget(
                      questionDetailDto: questionDetailDto,
                    ),
                  ),
                  if (questionDetailDto.questionPhotoPathList.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ExpandablePageView.builder(
                          controller: PageController(viewportFraction: 0.85),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              questionDetailDto.questionPhotoPathList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: QuestionPictureWidget(
                                    photoPath: questionDetailDto
                                        .questionPhotoPathList[index],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    )
                ],
              ),
              loading: () => const LoadingOverlay(),
              error: (error, stack) {
                return const Center(
                    child: Column(
                  children: [
                    TextForError(),
                  ],
                ));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            getAnswerControllerState.when(
              data: (answerDto) => answerDto.isNotEmpty
                  ? Column(
                      children: [
                        ExpandablePageView.builder(
                          controller: PageController(viewportFraction: 0.85),
                          itemCount: answerDto.length,
                          onPageChanged: (newIndex) {
                            selectedAnswerIndex.value = newIndex;
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 5,
                                    ),
                                    //shadowがlistViewで見きれないようにするようのpadding。自由に調整して頂けると（上のshadow見切れてるので）
                                    child: Column(
                                      children: [
                                        AnswerCardWidget(
                                          answerDto: answerDto[index],
                                        ),
                                      ],
                                    )),
                              ],
                            );
                          },
                        ),
                        if (answerDto[selectedAnswerIndex.value]
                            .answerPhotoList
                            .isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ExpandablePageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.85),
                                scrollDirection: Axis.horizontal,
                                itemCount: answerDto[selectedAnswerIndex.value]
                                    .answerPhotoList
                                    .length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: AnswerPictureWidget(
                                      photoPath:
                                          answerDto[selectedAnswerIndex.value]
                                              .answerPhotoList[index],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        if (!answerDto[selectedAnswerIndex.value].isEvaluated &&
                            isMyQuestion)
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextButtonForNavigatingToEvaluationPage(
                                teacherId: answerDto[selectedAnswerIndex.value]
                                    .teacherId,
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : Text("回答までしばらくお待ちください",
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                          color: ColorSet.of(context).text)),
              loading: () => const LoadingOverlay(),
              error: (error, stack) {
                return const Center(
                    child: Column(
                  children: [
                    TextForError(),
                  ],
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
