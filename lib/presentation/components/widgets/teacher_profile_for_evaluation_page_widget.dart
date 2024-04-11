import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
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
import 'teacher_profile_for_evaluation_page_skeleton_widget.dart';

class TeacherProfileForEvaluationPageWidget extends ConsumerWidget {
  final TeacherId teacherId;
  const TeacherProfileForEvaluationPageWidget({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final getTeacherProfileControllerState =
        ref.watch(getTeacherProfileControllerProvider(teacherId));

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(teacherId)
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
          .deleteFavoriteTeacher(teacherId)
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

    void navigateToTeacherProfilePage(BuildContext context) {
      context.push(PageId.teacherProfile.path, extra: teacherId);
    }

    return getTeacherProfileControllerState.when(
      data: (getTeacherProfileDto) {
        if (getTeacherProfileDto != null) {
          final image = ref
              .watch(getPhotoControllerProvider(
                  getTeacherProfileDto.profilePhotoPath))
              .maybeWhen(
                data: (d) => d,
                loading: () {
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? const AssetImage(
                          "assets/photos/loading_user_icon_light.png")
                      : const AssetImage(
                          "assets/photos/loading_user_icon_dark.png");
                },
                orElse: () =>
                    const AssetImage("assets/photos/sample_user_icon.jpg"),
              );
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => navigateToTeacherProfilePage(context),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: screenWidth < 600 ? 30 : 45,
                        backgroundImage: image,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          getTeacherProfileDto.name,
                          style: TextStyle(
                              fontWeight: FontWeightSet.normal,
                              fontSize: FontSizeSet.getFontSize(
                                  context, FontSizeSet.header2),
                              color: ColorSet.of(context).text),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              getTeacherProfileDto.isFollowing
                  ? TextButtonForUnFollowTeacher(
                      onPressed: deleteFavoriteTeacher,
                    )
                  : TextButtonForFollowTeacher(
                      onPressed: addFavoriteTeacher,
                    ),
            ],
          );
        } else {
          return Text(
            "プロフないっす、アカウント消したかもっす",
            style: TextStyle(color: ColorSet.of(context).text),
          );
        }
      },
      loading: () => const TeacherProfileForEvaluationPageSkeletonWidget(),
      error: (error, stack) {
        return Center(
            child: Column(
          children: [
            Text(
              error.toString(),
              style: TextStyle(color: ColorSet.of(context).errorText),
            )
            // TextForError(),
          ],
        ));
      },
    );
  }
}
