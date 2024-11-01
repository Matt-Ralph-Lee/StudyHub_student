import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/answer_list/models/answer_id.dart';
import '../../domain/question/models/question_id.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/widgets/confirm_resolve_question_modal_widget.dart';
import '../components/widgets/confirm_teacher_evaluation_modal_widget.dart';
import '../components/widgets/evaluation_stars_widget.dart';
import '../components/widgets/evaluation_text_field_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/error_modal_widget.dart';
import '../components/widgets/teacher_profile_for_evaluation_page_widget.dart';
import '../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../controllers/add_teacher_evaluation_controller/add_teacher_evaluation_controller.dart';
import '../controllers/resolve_question_controller/resolve_question_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/utils/handle_error.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

//i
class EvaluationPage extends HookConsumerWidget {
  final AnswerId fromAnswer;
  final QuestionId fromQuestion;
  final TeacherId teacherId;
  const EvaluationPage({
    super.key,
    required this.teacherId,
    required this.fromAnswer,
    required this.fromQuestion,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numOfSelectedStars = useState<int>(0);
    final evaluationTextController = useTextEditingController();
    final isEvaluationTextValid = useState<bool>(false);
    final addFavoriteTeacherControllerState =
        ref.watch(addFavoriteTeacherControllerProvider);
    final teacherEvaluationControllerState =
        ref.watch(addTeacherEvaluationControllerProvider);

    void setEvaluationStars(int starNumber) {
      numOfSelectedStars.value = starNumber + 1;
    }

    void checkEvaluationTextFilled(String text) {
      isEvaluationTextValid.value = text.length > 10 && text.length < 200;
    }

    void resolveQuestion() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmResolveQuestionModalWidget();
          });
      if (result) {
        await ref
            .read(resolveQuestionControllerProvider.notifier)
            .resolveQuestion(
              fromQuestion,
            );
        if (!context.mounted) return;
        final currentState = ref.read(resolveQuestionControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
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
            completionSnackBar(
              context,
              L10n.resolveQuestionSnackbarText,
            ),
          );
          context.pop();
        }
      } else {
        if (!context.mounted) return;
        context.pop(); //これ解決策がわからん、一応動きはする
      }
    }

    void evaluateTeacher() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmTeacherEvaluationModalWidget(
              numOfEvaluationStars: numOfSelectedStars.value,
              evaluationText: evaluationTextController.text,
            );
          });
      if (result) {
        await ref
            .read(addTeacherEvaluationControllerProvider.notifier)
            .addTeacherEvaluation(
              answerId: fromAnswer,
              questionId: fromQuestion,
              teacherId: teacherId,
              ratingData: numOfSelectedStars.value,
              commentData: evaluationTextController.text,
            );

        if (!context.mounted) return;

        final currentState = ref.read(addTeacherEvaluationControllerProvider);
        if (currentState.hasError) {
          final error = currentState.error;
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
          resolveQuestion();
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    L10n.cancelText,
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                          context,
                          FontSizeSet.body,
                        ),
                        color: ColorSet.of(context).text),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 250,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed:
                    numOfSelectedStars.value != 0 && isEvaluationTextValid.value
                        ? () => evaluateTeacher()
                        : null,
                style: TextButton.styleFrom(
                    foregroundColor: ColorSet.of(context).primary,
                    disabledForegroundColor:
                        ColorSet.of(context).unselectedText),
                child: Text(
                  L10n.evaluationText,
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.getFontSize(
                      context,
                      FontSizeSet.body,
                    ),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: ColorSet.of(context).background,
        ),
        backgroundColor: ColorSet.of(context).background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PaddingSet.getPaddingSize(
                context,
                20,
              ),
              vertical: PaddingSet.getPaddingSize(
                context,
                20,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeacherProfileForEvaluationPageWidget(
                  teacherId: teacherId,
                ),
                const SizedBox(
                  height: 70,
                ),
                EvaluationStarsWidget(
                  numOfSelectedStars: numOfSelectedStars.value,
                  onPressed: setEvaluationStars,
                ),
                const SizedBox(
                  height: 70,
                ),
                EvaluationTextFieldWidget(
                  controller: evaluationTextController,
                  onChanged: checkEvaluationTextFilled,
                ),
                if (addFavoriteTeacherControllerState.isLoading ||
                    teacherEvaluationControllerState.isLoading)
                  const LoadingOverlay(),
              ],
            ),
          ),
        ));
  }
}
