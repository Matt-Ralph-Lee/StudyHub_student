import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/answer_list/models/answer_id.dart';
import '../../domain/question/models/question_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/parts/text_button_for_add_bookmark.dart';
import '../components/parts/text_button_for_delete_bookmark.dart';
import '../components/parts/text_button_for_navigating_to_evaluatin_page.dart';
import '../components/parts/text_for_error.dart';
import '../components/widgets/answer_card_skeleton_widget.dart';
import '../components/widgets/answer_card_widget.dart';
import '../components/widgets/answer_picture_widget.dart';
import '../components/widgets/question_detail_card_skeleton_widget.dart';
import '../components/widgets/question_detail_card_widget.dart';
import '../components/widgets/question_pictures_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../controllers/add_bookmark_controller/add_bookmark_controller.dart';
import '../controllers/delete_bookmark_controller/delete_bookmark_controller.dart';
import '../controllers/get_answer_controller/get_answer_controller.dart';
import '../controllers/get_question_detail_controller/get_question_detail_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/utils/handle_error.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//questionCardの方が、widthをdouble.infinityにして上からhorizontalPaddingかけてる一方で
//写真なり回答なりはviewPortFractionを使って画面の横幅ベースで横幅を決めてる
//スマホに合わせてそれっぽいviewPortFraction（0.9）セットしてるけど
//ipadとか端末によっては左端が揃わなかったり回答が一つしかないときに萎んだり等々、絶妙に気持ち悪いけど解決策わからん
class QuestionAndAnswerPage extends HookConsumerWidget {
  final QuestionId questionId;
  final bool isMyQuestion;
  final AnswerId? answerId;
  const QuestionAndAnswerPage({
    super.key,
    required this.questionId,
    required this.isMyQuestion,
    required this.answerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getQuestionDetailControllerState =
        ref.watch(getQuestionDetailControllerProvider(questionId));
    final getAnswerControllerState =
        ref.watch(getAnswerControllerProvider(questionId));

    final selectedAnswerIndex = useState(0);

    void addBookmark() async {
      await ref
          .read(addBookmarkControllerProvider.notifier)
          .addBookmark(questionId);

      if (!context.mounted) return;

      final addBookmarkControllerState =
          ref.read(addBookmarkControllerProvider);
      if (addBookmarkControllerState.hasError) {
        final error = addBookmarkControllerState.error;
        final errorMessage = handleError(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorModalWidget(
              errorMessage: errorMessage,
            );
          },
        );
      } else {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          completionSnackBar(context, L10n.addBookmarkText),
        );
      }
    }

    void deleteBookmark() async {
      await ref
          .read(deleteBookmarkControllerProvider.notifier)
          .deleteBookmark(questionId);

      if (!context.mounted) return;

      final deleteBookmarkControllerState =
          ref.read(deleteBookmarkControllerProvider);
      if (deleteBookmarkControllerState.hasError) {
        final error = deleteBookmarkControllerState.error;
        final errorMessage = handleError(error);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorModalWidget(
              errorMessage: errorMessage,
            );
          },
        );
      } else {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          completionSnackBar(context, L10n.deleteBookmarkText),
        );
      }
    }

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
        actions: [
          getQuestionDetailControllerState.when(
            data: (getQuestionDetailProfileDto) =>
                getQuestionDetailProfileDto.isBookmarked
                    ? TextButtonForDeleteBookmark(
                        onPressed: deleteBookmark,
                      )
                    : TextButtonForAddBookmark(
                        onPressed: addBookmark,
                      ),
            loading: () => const SizedBox(
              width: 0,
            ),
            error: (error, stack) => const TextForError(),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getQuestionDetailControllerState.when(
              data: (questionDetailDto) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      PaddingSet.getPaddingSize(
                        context,
                        PaddingSet.horizontalPadding,
                      ),
                    ),
                    child: QuestionDetailCardWidget(
                      questionDetailDto: questionDetailDto,
                    ),
                  ),
                  if (questionDetailDto.questionPhotoPathList.isNotEmpty)
                    ExpandablePageView.builder(
                      // alignment: Alignment.,
                      controller: PageController(
                          viewportFraction:
                              0.9), //viewportFractionを通してしかpadding設定できそうなので（他ぺーじとは違ってピクセルで左端paddingとってない）
                      scrollDirection: Axis.horizontal,
                      itemCount: questionDetailDto.questionPhotoPathList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            right: PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.pageViewItemLightPadding,
                            ),
                          ),
                          child: QuestionPictureWidget(
                            photoPath:
                                questionDetailDto.questionPhotoPathList[index],
                            order: index,
                            questionDetailDto: questionDetailDto,
                          ),
                        );
                      },
                    )
                ],
              ),
              loading: () => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      PaddingSet.getPaddingSize(
                        context,
                        PaddingSet.horizontalPadding,
                      ),
                    ),
                    child: const QuestionDetailCardSkeletonWidget(),
                  ),
                  ExpandablePageView.builder(
                    // alignment: Alignment.,
                    controller: PageController(
                        viewportFraction:
                            0.9), //viewportFractionを通してしかpadding設定できそうなので（他ぺーじとは違ってピクセルで左端paddingとってない）
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: ColorSet.of(context).simmerBase,
                        highlightColor: ColorSet.of(context).simmerHighlight,
                        child: Container(
                          margin: EdgeInsets.only(
                            right: PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.pageViewItemLightPadding,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
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
              height: 20,
            ),
            getAnswerControllerState.when(
              data: (answerDto) {
                int initialIndex = 0;
                if (answerId != null) {
                  initialIndex = answerDto
                      .indexWhere((answer) => answer.answerId == answerId);
                  initialIndex = initialIndex == -1 ? 0 : initialIndex;
                }
                selectedAnswerIndex.value = initialIndex;
                return answerDto.isNotEmpty
                    ? Column(
                        children: [
                          ExpandablePageView.builder(
                            controller: PageController(
                              viewportFraction: 0.9,
                              initialPage: initialIndex,
                            ),
                            itemCount: answerDto.length,
                            onPageChanged: (newIndex) {
                              selectedAnswerIndex.value = newIndex;
                            },
                            itemBuilder: (context, index) {
                              return answerDto.length == 1
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: AnswerCardWidget(
                                        answerDto: answerDto[index],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: PaddingSet.getPaddingSize(
                                            context,
                                            PaddingSet.pageViewItemLightPadding,
                                          ),
                                        ),
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
                            ExpandablePageView.builder(
                              controller: PageController(
                                viewportFraction: 0.9,
                                initialPage: initialIndex,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: answerDto[selectedAnswerIndex.value]
                                  .answerPhotoList
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: PaddingSet.getPaddingSize(
                                      context,
                                      PaddingSet.pageViewItemLightPadding,
                                    ),
                                  ), //marginなので？組み込まずに外からかけてます
                                  child: AnswerPictureWidget(
                                    photoPath:
                                        answerDto[selectedAnswerIndex.value]
                                            .answerPhotoList[index],
                                    answerDto:
                                        answerDto[selectedAnswerIndex.value],
                                    order: selectedAnswerIndex.value,
                                  ),
                                );
                              },
                            ),
                          if (!answerDto[selectedAnswerIndex.value]
                                  .isEvaluated &&
                              isMyQuestion)
                            Padding(
                              padding: EdgeInsets.all(
                                PaddingSet.getPaddingSize(
                                  context,
                                  PaddingSet.horizontalPadding,
                                ),
                              ),
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
              loading: () => Column(
                children: [
                  ExpandablePageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: 3,
                    onPageChanged: (newIndex) {
                      selectedAnswerIndex.value = newIndex;
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          margin: EdgeInsets.only(
                            right: PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.pageViewItemLightPadding,
                            ),
                          ),
                          child: const AnswerCardSkeletonWidget(),
                        ),
                      );
                    },
                  ),
                  ExpandablePageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: ColorSet.of(context).simmerBase,
                        highlightColor: ColorSet.of(context).simmerHighlight,
                        child: Container(
                          margin: EdgeInsets.only(
                            right: PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.pageViewItemLightPadding,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
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
