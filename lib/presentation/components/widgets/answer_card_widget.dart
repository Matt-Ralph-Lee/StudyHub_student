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

    void toggleLikeAnswer() async {
      if (answerDto.hasLiked) {
        HapticFeedback.lightImpact();
        ref.read(likeAnswerControllerProvider.notifier).decrement(
              answerId: answerDto.answerId,
              questionId: answerDto.questionId,
            );
      } else {
        HapticFeedback.lightImpact();
        ref.read(likeAnswerControllerProvider.notifier).increment(
              answerId: answerDto.answerId,
              questionId: answerDto.questionId,
            );
      }
    }

    void navigateToTeacherProfilePage(
        BuildContext context, TeacherId teacherId) {
      context.push(PageId.teacherProfile.path, extra: teacherId);
    }

    void navigateToReportPage(BuildContext context, TeacherId teacherId) {
      context.push(
        PageId.reportQuestionPage.path,
        extra: [
          null,
          teacherId,
        ],
      );
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
          ScaffoldMessenger.of(context).showSnackBar(
            completionSnackBar(context, L10n.deleteFavoriteTeacherText),
          );
        }
      });
    }

    final image = ref
        .watch(getPhotoControllerProvider(answerDto.teacherProfilePath))
        .maybeWhen(
          data: (d) => d,
          loading: () {
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_light.png")
                : const AssetImage(
                    "assets/photos/profile_photo/loading_user_icon_dark.png");
          },
          orElse: () => const AssetImage(
              "assets/photos/profile_photo/sample_user_icon.jpg"),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => navigateToTeacherProfilePage(
                        context, answerDto.teacherId),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth < 600 ? 15 : 22,
                          backgroundImage: image,
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
                                context,
                                FontSizeSet.body,
                              ),
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
                //元祖StudyHubから移植。モーダルだと位置調整だるそうなので。いらないプロパティありそうだけど放置！
                PopupMenuButton<String>(
                  color: ColorSet.of(context).surface,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: ColorSet.of(context).text,
                    size: FontSizeSet.getFontSize(context, FontSizeSet.header2),
                  ),
                  onSelected: (String result) {
                    if (result == L10n.reportText) {
                      navigateToReportPage(
                        context,
                        answerDto.teacherId,
                      );
                    } else {
                      answerDto.isFollowing
                          ? deleteFavoriteTeacher()
                          : addFavoriteTeacher();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: L10n.reportText,
                      child: Text(
                        L10n.reportText,
                        style: TextStyle(
                          color: ColorSet.of(context).text,
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: "followUnFollow",
                      child: Text(
                        answerDto.isFollowing
                            ? L10n.unFollowButtonTextForAnswerCardMenu
                            : L10n.followButtonText,
                        style: TextStyle(
                          color: ColorSet.of(context).primary,
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.body),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    width: screenWidth < 600 ? 30 : 44,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          answerDto.hasLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: FontSizeSet.getFontSize(
                            context,
                            FontSizeSet.header3,
                          ),
                          color: ColorSet.of(context).primary,
                        ),
                        const SizedBox(
                          height: 3,
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
                  width: 20,
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
