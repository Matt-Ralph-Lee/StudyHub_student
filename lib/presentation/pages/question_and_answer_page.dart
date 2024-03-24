import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/shared/application_service/question_card_dto.dart';
import '../../domain/question/models/question_id.dart';
import '../components/parts/text_button_for_navigating_to_evaluatin_page.dart';
import '../components/parts/text_for_error.dart';
import '../components/widgets/answer_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/question_detail_card_widget.dart';
import '../components/widgets/question_pictures_widget.dart';
import '../controllers/get_answer_controller/get_answer_controller.dart';
import '../controllers/get_question_detail_controller/get_question_detail_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class QuestionAndAnswerPage extends ConsumerWidget {
  final QuestionId questionId;
  final QuestionCardDto questionCardDto;
  final bool isMyQuestionNoEvaluated;
  const QuestionAndAnswerPage({
    super.key,
    required this.questionId,
    required this.questionCardDto,
    required this.isMyQuestionNoEvaluated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getQuestionDetailControllerState =
        ref.watch(getQuestionDetailControllerProvider(questionId));
    final getAnswerControllerState =
        ref.watch(getAnswerControllerProvider(questionId));

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
            "Q&A",
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
                    QuestionDetailCardWidget(
                      questionDetailDto: questionDetailDto,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: questionDetailDto.questionPhotoPathList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: QuestionPictureWidget(
                            photoPath:
                                questionDetailDto.questionPhotoPathList[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                loading: () => const LoadingOverlay(),
                error: (error, stack) {
                  print("エラーはこれです${error}");
                  print(stack);
                  return const Center(
                      child: Column(
                    children: [
                      TextForError(),
                    ],
                  ));
                },
              ),
              const SizedBox(
                height: 50,
              ),
              getAnswerControllerState.when(
                data: (answerDto) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: answerDto.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnswerCardWidget(
                          answerDto: answerDto[index],
                        ));
                  },
                ),
                loading: () => const LoadingOverlay(),
                error: (error, stack) {
                  print("エラーはこれです${error}");
                  print(stack);
                  return const Center(
                      child: Column(
                    children: [
                      TextForError(),
                    ],
                  ));
                },
              ),
              if (isMyQuestionNoEvaluated)
                const TextButtonForNavigatingToEvaluationPage()
            ],
          ),
        ));
  }
}
