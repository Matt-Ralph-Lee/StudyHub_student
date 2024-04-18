import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/blockings/exception/blockings_use_case_exception.dart';
import '../../../application/blockings/exception/blockings_use_case_exception_detail.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../controllers/add_blockings_controller/add_blockings_controller.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_blockings_controller/delete_blockings_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';
import 'confirm_add_blocking_modal.dart';
import 'confirm_delete_blocking_modal.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class TeacherProfileWidget extends ConsumerWidget {
  final GetTeacherProfileDto teacherProfileDto;

  const TeacherProfileWidget({super.key, required this.teacherProfileDto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    void addBlocking() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmAddBlockingModalWidget();
          });
      if (result) {
        ref
            .read(addBlockingsControllerProvider.notifier)
            .addBlockings(teacherProfileDto.teacherId)
            .then((_) {
          final addBlockingsState = ref.read(addBlockingsControllerProvider);
          if (addBlockingsState.hasError) {
            final error = addBlockingsState.error;
            if (error is BlockingsUseCaseException) {
              final errorText = L10n.blockingsUseCaseExceptionMessage(
                  error.detail as BlockingsUseCaseExceptionDetail);
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
              completionSnackBar(
                context,
                L10n.blockSnackBarText,
              ),
            );
            context.pop();
          }
        });
      }
    }

    void deleteBlocking() async {
      final result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmDeleteBlockingModalWidget();
          });
      if (result) {
        ref
            .read(deleteBlockingsControllerProvider.notifier)
            .deleteBlockings(teacherProfileDto.teacherId)
            .then((_) {
          final deleteBlockingsState =
              ref.read(deleteBlockingsControllerProvider);
          if (deleteBlockingsState.hasError) {
            final error = deleteBlockingsState.error;
            if (error is BlockingsUseCaseException) {
              final errorText = L10n.blockingsUseCaseExceptionMessage(
                  error.detail as BlockingsUseCaseExceptionDetail);
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
              completionSnackBar(
                context,
                L10n.deleteBlockSnackBarText,
              ),
            );
            context.pop();
          }
        });
      }
    }

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(teacherProfileDto.teacherId)
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
          .deleteFavoriteTeacher(teacherProfileDto.teacherId)
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
        .watch(getPhotoControllerProvider(teacherProfileDto.profilePhotoPath))
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: screenWidth < 600 ? 40 : 60,
                  backgroundImage: image,
                ),
                SizedBox(
                  width: PaddingSet.getPaddingSize(
                    context,
                    20,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        teacherProfileDto.name,
                        style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header2),
                          color: ColorSet.of(context).text,
                        ),
                      ),
                      SizedBox(
                        height: PaddingSet.getPaddingSize(
                          context,
                          20,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: teacherProfileDto.rating.toDouble(),
                            ignoreGestures: true,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.header2),
                            itemPadding: EdgeInsets.only(
                                right: PaddingSet.getPaddingSize(
                              context,
                              5,
                            )),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: ColorSet.of(context).primary,
                            ),
                            onRatingUpdate: (double value) {},
                          ),
                          SizedBox(
                            width: PaddingSet.getPaddingSize(
                              context,
                              10,
                            ),
                          ),
                          Text(
                            teacherProfileDto.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header2),
                              color: ColorSet.of(context).text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                    if (result == "followUnFollow") {
                      teacherProfileDto.isFollowing
                          ? deleteFavoriteTeacher()
                          : addFavoriteTeacher();
                    } else {
                      teacherProfileDto.isBlocking
                          ? deleteBlocking()
                          : addBlocking();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "followUnFollow",
                      child: Text(
                        teacherProfileDto.isFollowing
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
                        teacherProfileDto.isBlocking
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
            SizedBox(
              height: PaddingSet.getPaddingSize(
                context,
                30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.favoriteSubjectText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      SizedBox(
                        height: PaddingSet.getPaddingSize(
                          context,
                          3,
                        ),
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: PaddingSet.getPaddingSize(
                    context,
                    5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: teacherProfileDto.bestSubjects.map((subject) {
                    return Text(
                      subject,
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize:
                            FontSizeSet.getFontSize(context, FontSizeSet.body),
                        color: ColorSet.of(context).text,
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
            SizedBox(
              height: PaddingSet.getPaddingSize(
                context,
                30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.bioText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      SizedBox(
                        height: PaddingSet.getPaddingSize(
                          context,
                          3,
                        ),
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: PaddingSet.getPaddingSize(
                    context,
                    5,
                  ),
                ),
                Text(
                  teacherProfileDto.bio,
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: PaddingSet.getPaddingSize(
                context,
                30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.selfIntroductionText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      SizedBox(
                        height: PaddingSet.getPaddingSize(
                          context,
                          3,
                        ),
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: PaddingSet.getPaddingSize(
                    context,
                    5,
                  ),
                ),
                Text(
                  teacherProfileDto.introduction,
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: PaddingSet.getPaddingSize(
                context,
                30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L10n.careerText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      SizedBox(
                        height: PaddingSet.getPaddingSize(
                          context,
                          3,
                        ),
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: PaddingSet.getPaddingSize(
                    context,
                    5,
                  ),
                ),
                Text(
                  "${teacherProfileDto.highSchool} ${L10n.fromText}\n${teacherProfileDto.university} ${L10n.enrollmentText}",
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text,
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
