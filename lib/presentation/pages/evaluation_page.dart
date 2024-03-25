import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception.dart';
import '../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception_detail.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/widgets/confirm_teacher_evaluation_modal_widget.dart';
import '../components/widgets/evaluation_stars_widget.dart';
import '../components/widgets/evaluation_text_field_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/teacher_profile_for_evaluation_page_widget.dart';
import '../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../controllers/add_teacher_evaluation_controller/add_teacher_evaluation_controller.dart';
import '../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

//i
class EvaluationPage extends HookConsumerWidget {
  final TeacherId teacherId;
  const EvaluationPage({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;
    final numOfSelectedStars = useState<int>(0);
    final evaluationTextController = useTextEditingController();
    final isEvaluationTextFilled = useState<bool>(false);
    final addFavoriteTeacherControllerState =
        ref.watch(addFavoriteTeacherControllerProvider);
    final deleteFavoriteTeacherControllerState =
        ref.watch(deleteFavoriteTeacherControllerProvider);
    final teacherEvaluationControllerState =
        ref.watch(addTeacherEvaluationControllerProvider);

    void setEvaluationStars(int starNumber) {
      numOfSelectedStars.value = starNumber + 1;
    }

    void checkEvaluationTextFilled(String text) {
      isEvaluationTextFilled.value = text.isNotEmpty;
    }

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(teacherId)
          .then((_) {
        if (addFavoriteTeacherControllerState is AsyncError) {
          final error = addFavoriteTeacherControllerState.error;
          if (error is FavoriteTeachersUseCaseException) {
            final errorText = L10n.favoriteTeacherUseCaseExceptionMessage(
                error.detail as FavoriteTeachersUseCaseExceptionDetail);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SpecificExceptionModalWidget(
                    errorMessage: errorText,
                  );
                });
          } else {
            showErrorModalWidget(context);
          }
        } else {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            CompletionSnackBar(context, "お気に入りに追加しました"),
          );
        }
      });
    }

    void deleteFavoriteTeacher() async {
      ref
          .read(deleteFavoriteTeacherControllerProvider.notifier)
          .deleteFavoriteTeacher(teacherId)
          .then((_) {
        if (deleteFavoriteTeacherControllerState is AsyncError) {
          final error = deleteFavoriteTeacherControllerState.error;
          if (error is FavoriteTeachersUseCaseException) {
            final errorText = L10n.favoriteTeacherUseCaseExceptionMessage(
                error.detail as FavoriteTeachersUseCaseExceptionDetail);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SpecificExceptionModalWidget(
                    errorMessage: errorText,
                  );
                });
          } else {
            showErrorModalWidget(context);
          }
        } else {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            CompletionSnackBar(context, "お気に入りから削除しました"),
          );
        }
      });
    }

    void evaluateTeacher() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            final evaluationTextController = useTextEditingController();
            return ConfirmTeacherEvaluationModalWidget(
              numOfEvaluationStars: numOfSelectedStars.value,
              evaluationText: evaluationTextController.text,
            );
          });
      if (result) {
        ref
            .read(addTeacherEvaluationControllerProvider.notifier)
            .addTeacherEvaluation(
              teacherId,
              numOfSelectedStars.value,
              evaluationTextController.text,
            )
            .then((_) {
          if (teacherEvaluationControllerState is AsyncError) {
            final error = teacherEvaluationControllerState.error;
            if (error is EvaluationUseCaseException) {
              final errorText = L10n.evaluationUseCaseExceptionMessage(
                  error.detail as EvaluationUseCaseExceptionDetail);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SpecificExceptionModalWidget(
                      errorMessage: errorText,
                    );
                  });
            } else {
              showErrorModalWidget(context);
            }
          } else {
            HapticFeedback.lightImpact();
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              CompletionSnackBar(context, "講師を評価しました"),
            );
          }
        });
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
                    "キャンセル",
                    style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.header3),
                        color: ColorSet.of(context).text),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 130,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: numOfSelectedStars.value != 0 &&
                        isEvaluationTextFilled.value
                    ? () => evaluateTeacher()
                    : null,
                style: TextButton.styleFrom(
                    foregroundColor: ColorSet.of(context).primary,
                    disabledForegroundColor:
                        ColorSet.of(context).unselectedText),
                child: Text(
                  "評価する",
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.header3),
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
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeacherProfileForEvaluationPageWidget(
                  teacherId: teacherId,
                ),
                const SizedBox(
                  height: 100,
                ),
                EvaluationStarsWidget(
                  numOfSelectedStars: numOfSelectedStars.value,
                  onPressed: setEvaluationStars,
                ),
                const SizedBox(
                  height: 70,
                ),
                EvaluationTextWidget(
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
