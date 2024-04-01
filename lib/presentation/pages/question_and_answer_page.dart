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
import '../shared/constants/padding_set.dart';

//paddingなりsizedBoxなりのレスポンシブ忘れるので暇なときに少しずつ差し替えます（ここに限らず）
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.07;
    // 画面の幅を利用したウィジェットの構築
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
            size: FontSizeSet.getFontSize(
              context,
              30,
            ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getQuestionDetailControllerState.when(
              data: (questionDetailDto) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      PaddingSet.getPaddingSize(
                        context,
                        horizontalPadding,
                      ),
                    ),
                    child: QuestionDetailCardWidget(
                      questionDetailDto: questionDetailDto,
                    ),
                  ),
                  if (questionDetailDto.questionPhotoPathList.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: PaddingSet.getPaddingSize(
                          context,
                          4,
                        ),
                      ),
                      child: ExpandablePageView.builder(
                        controller: PageController(
                            viewportFraction:
                                0.86), //viewportFractionを通してしかpadding設定できそうなので（他ぺーじとは違ってピクセルで左端paddingとってない）
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            questionDetailDto.questionPhotoPathList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              right: PaddingSet.getPaddingSize(
                                context,
                                15,
                              ),
                            ), //marginなので？組み込まずに外からかけてます
                            child: QuestionPictureWidget(
                              photoPath: questionDetailDto
                                  .questionPhotoPathList[index],
                            ),
                          );
                        },
                      ),
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
              data: (answerDto) {
                return answerDto.isNotEmpty
                    ? Column(
                        children: [
                          ExpandablePageView.builder(
                            controller: PageController(viewportFraction: 0.86),
                            itemCount: answerDto.length,
                            onPageChanged: (newIndex) {
                              selectedAnswerIndex.value = newIndex;
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 5,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: PaddingSet.getPaddingSize(
                                      context,
                                      15,
                                    ),
                                  ), //marginなので？組み込まずに外からかけてます
                                  child: AnswerCardWidget(
                                    answerDto: answerDto[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          if (answerDto[selectedAnswerIndex.value]
                              .answerPhotoList
                              .isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: ExpandablePageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.86),
                                scrollDirection: Axis.horizontal,
                                itemCount: answerDto[selectedAnswerIndex.value]
                                    .answerPhotoList
                                    .length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: PaddingSet.getPaddingSize(
                                          context,
                                          15,
                                        ),
                                      ), //marginなので？組み込まずに外からかけてます
                                      child: AnswerPictureWidget(
                                        photoPath:
                                            answerDto[selectedAnswerIndex.value]
                                                .answerPhotoList[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (!answerDto[selectedAnswerIndex.value]
                                  .isEvaluated &&
                              isMyQuestion)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: TextButtonForNavigatingToEvaluationPage(
                                teacherId: answerDto[selectedAnswerIndex.value]
                                    .teacherId,
                                fromAnswer: answerDto[selectedAnswerIndex.value]
                                    .answerId,
                                fromQuestion: questionId,
                              ),
                            ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      )
                    : Center(
                        child: Text(L10n.noAnswerText,
                            style: TextStyle(
                                fontWeight: FontWeightSet.normal,
                                fontSize: FontSizeSet.getFontSize(
                                    context, FontSizeSet.header3),
                                color: ColorSet.of(context).text)),
                      );
              },
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
