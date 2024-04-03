import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/application/answer/application_service/answer_dto.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
import '../parts/completion_snack_bar.dart';
import '../parts/text_button_for_follow_teacher.dart';
import '../parts/text_button_for_unfollow_teacher.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class AnswerMenuModalWidget extends ConsumerWidget {
  final AnswerDto answerDto;
  const AnswerMenuModalWidget({
    super.key,
    required this.answerDto,
  });

  @override
  Widget build(BuildContext context, ref) {
    void navigateToReportPage(BuildContext context, TeacherId teacherId) {
      context.push(
        PageId.reportQuestionPage.path,
        extra: [
          null,
          teacherId,
        ],
      );
      context.pop();
    }

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(answerDto.teacherId)
          .then((_) {
        final addFavoriteTeacherControllerState =
            ref.read(addFavoriteTeacherControllerProvider);
        if (addFavoriteTeacherControllerState.hasError) {
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
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.addFavoriteTeacherText),
          );
        }
      });
    }

    void deleteFavoriteTeacher() async {
      ref
          .read(deleteFavoriteTeacherControllerProvider.notifier)
          .deleteFavoriteTeacher(answerDto.teacherId)
          .then((_) {
        final deleteFavoriteTeacherControllerState =
            ref.read(deleteFavoriteTeacherControllerProvider);
        if (deleteFavoriteTeacherControllerState.hasError) {
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
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.deleteFavoriteTeacherText),
          );
        }
      });
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorSet.of(context).surface),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => navigateToReportPage(
              context,
              answerDto.teacherId,
            ),
            child: Text(
              L10n.reportText,
              style: TextStyle(
                //エラーテキストのカラーは赤が一般的、、？であればcolorsetに定義しておく？
                color: ColorSet.of(context).text,
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          answerDto.isFollowing
              ? TextButtonForUnFollowTeacher(
                  onPressed: () => deleteFavoriteTeacher())
              : TextButtonForFollowTeacher(
                  onPressed: () => addFavoriteTeacher()),
        ],
      ),
    );
  }
}
