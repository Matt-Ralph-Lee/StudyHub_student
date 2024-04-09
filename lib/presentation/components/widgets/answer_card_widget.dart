import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../controllers/like_answer_controller/like_answer_controller.dart';
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

class AnswerCardWidget extends ConsumerWidget {
  final AnswerDto answerDto;

  const AnswerCardWidget({
    super.key,
    required this.answerDto,
  });

  @override
  Widget build(BuildContext context, ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final deleteFavoriteTeacherControllerState =
        ref.watch(deleteFavoriteTeacherControllerProvider);

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
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.deleteFavoriteTeacherText),
          );
        }
      });
    }

    void toggleLikeAnswer() async {
      if (answerDto.hasLiked) {
        ref.read(likeAnswerControllerProvider.notifier).decrement(
            answerId: answerDto.answerId, questionId: answerDto.questionId);
      } else {
        ref.read(likeAnswerControllerProvider.notifier).increment(
            answerId: answerDto.answerId, questionId: answerDto.questionId);
      }
    }

    void navigateToTeacherProfilePage(
        BuildContext context, TeacherId teacherId) {
      context.push(PageId.teacherProfile.path, extra: teacherId);
    }

    final image = ref
        .watch(getPhotoControllerProvider(answerDto.teacherProfilePath))
        .maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/sample_picture_hd.jpg"),
        );

    return Container(
      width: screenWidth * 0.8, //ここ適当。
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => navigateToTeacherProfilePage(
                        context, answerDto.teacherId),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth < 600 ? 15 : 22,
                          backgroundImage:
                              // answerDto.teacherProfilePath.contains("assets")
                              //     ? AssetImage(answerDto.teacherProfilePath)
                              //         as ImageProvider
                              //     : NetworkImage(
                              //         answerDto.teacherProfilePath,
                              //       ),
                              image,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            answerDto.teacherName,
                            style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header3),
                              color: ColorSet.of(context).text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                answerDto.isFollowing
                    ? TextButtonForUnFollowTeacher(
                        onPressed: () => deleteFavoriteTeacher())
                    : TextButtonForFollowTeacher(
                        onPressed: () => addFavoriteTeacher()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: toggleLikeAnswer,
                  child: SizedBox(
                    width: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          answerDto.hasLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 17,
                          color: ColorSet.of(context).primary,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          answerDto.answerLike.toString(),
                          style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    answerDto.answerText,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize:
                          FontSizeSet.getFontSize(context, FontSizeSet.body),
                      color: ColorSet.of(context).text,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
