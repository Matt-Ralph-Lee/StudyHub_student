import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/answer/application_service/answer_dto.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/add_blockings_controller/add_blockings_controller.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_blockings_controller/delete_blockings_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../controllers/like_answer_controller/like_answer_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/utils/handle_error.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';
import '../parts/completion_snack_bar.dart';
import 'confirm_add_blocking_modal.dart';
import 'confirm_delete_blocking_modal.dart';
import 'error_modal_widget.dart';

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
      await ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(answerDto.teacherId);

      if (!context.mounted) return;

      final addFavoriteTeacherControllerState =
          ref.read(addFavoriteTeacherControllerProvider);
      if (addFavoriteTeacherControllerState.hasError) {
        final error = addFavoriteTeacherControllerState.error;
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
          completionSnackBar(context, L10n.addFavoriteTeacherText),
        );
      }
    }

    void deleteFavoriteTeacher() async {
      await ref
          .read(deleteFavoriteTeacherControllerProvider.notifier)
          .deleteFavoriteTeacher(answerDto.teacherId);

      if (!context.mounted) return;

      final deleteFavoriteTeacherControllerState =
          ref.read(deleteFavoriteTeacherControllerProvider);
      if (deleteFavoriteTeacherControllerState.hasError) {
        final error = deleteFavoriteTeacherControllerState.error;
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
          completionSnackBar(context, L10n.deleteFavoriteTeacherText),
        );
      }
    }

    void addBlocking() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmAddBlockingModalWidget();
          });
      if (result) {
        await ref
            .read(addBlockingsControllerProvider.notifier)
            .addBlockings(answerDto.teacherId);

        if (!context.mounted) return;

        final addBlockingsState = ref.read(addBlockingsControllerProvider);
        if (addBlockingsState.hasError) {
          final error = addBlockingsState.error;
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
              L10n.blockSnackBarText,
            ),
          );
        }
      }
    }

    void deleteBlocking() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmDeleteBlockingModalWidget();
          });
      if (result) {
        await ref
            .read(deleteBlockingsControllerProvider.notifier)
            .deleteBlockings(answerDto.teacherId);

        if (!context.mounted) return;

        final deleteBlockingsState =
            ref.read(deleteBlockingsControllerProvider);
        if (deleteBlockingsState.hasError) {
          final error = deleteBlockingsState.error;
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
              L10n.deleteBlockSnackBarText,
            ),
          );
        }
      }
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
                    } else if (result == "followUnFollow") {
                      answerDto.isFollowing
                          ? deleteFavoriteTeacher()
                          : addFavoriteTeacher();
                    } else {
                      answerDto.isBlocking ? deleteBlocking() : addBlocking();
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
                    PopupMenuItem<String>(
                      value: "blockUnBlock",
                      child: Text(
                        answerDto.isBlocking
                            ? L10n.unBlockText
                            : L10n.blockText,
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
                            FontSizeSet.header1,
                          ),
                          color: ColorSet.of(context).primary,
                        ),
                        const SizedBox(
                          height: 7,
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
