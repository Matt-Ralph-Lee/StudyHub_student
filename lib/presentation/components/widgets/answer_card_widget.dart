import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../parts/completion_snack_bar.dart';
import '../parts/text_button_for_follow_teacher.dart';
import '../parts/text_button_for_unfollow_teacher.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class AnswerCardWidget extends ConsumerWidget {
  final AnswerDto answerDto;

  const AnswerCardWidget({
    super.key,
    required this.answerDto,
  });

  @override
  Widget build(BuildContext context, ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final addFavoriteTeacherControllerState =
        ref.watch(addFavoriteTeacherControllerProvider);
    final deleteFavoriteTeacherControllerState =
        ref.watch(deleteFavoriteTeacherControllerProvider);

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(answerDto.teacherId)
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
          .deleteFavoriteTeacher(answerDto.teacherId)
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

    return Column(
      children: [
        Text(
          "講師からの回答",
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
            color: ColorSet.of(context).text,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: screenWidth < 600 ? 155 : 220,
          decoration: BoxDecoration(
            color: ColorSet.of(context).surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: ColorSet.of(context).cardShadow,
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 0)),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(
              screenWidth < 600 ? 20 : 40,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage:
                          NetworkImage(answerDto.teacherProfilePath),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      answerDto.teacherName,
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.header3),
                        color: ColorSet.of(context).text,
                      ),
                    ),
                    answerDto.
                        ? TextButtonForFollowTeacher(
                            onPressed: addFavoriteTeacher)
                        : TextButtonForUnFollowTeacher(
                            onPressed: deleteFavoriteTeacher),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.heart_broken,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          answerDto.answerLike.toString(),
                          style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.body),
                            color: ColorSet.of(context).text,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            answerDto.answerText,
                            style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.body),
                              color: ColorSet.of(context).text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
