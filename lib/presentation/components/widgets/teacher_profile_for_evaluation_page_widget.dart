import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../parts/completion_snack_bar.dart';
import '../parts/text_button_for_follow_teacher.dart';
import '../parts/text_button_for_unfollow_teacher.dart';
import 'loading_overlay_widget.dart';
import 'show_error_modal_widget.dart';
import 'specific_exception_modal_widget.dart';

class TeacherProfileForEvaluationPageWidget extends ConsumerWidget {
  final TeacherId teacherId;
  const TeacherProfileForEvaluationPageWidget({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context, ref) {
    final getTeacherProfileControllerState =
        ref.watch(getTeacherProfileControllerProvider(teacherId));
    final addFavoriteTeacherControllerState =
        ref.watch(addFavoriteTeacherControllerProvider);
    final deleteFavoriteTeacherControllerState =
        ref.watch(deleteFavoriteTeacherControllerProvider);

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
            completionSnackBar(context, L10n.addFavoriteTeacherText),
          );
          ref.invalidate(getTeacherProfileControllerProvider(teacherId));
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
            completionSnackBar(context, L10n.deleteFavoriteTeacherText),
          );
          ref.invalidate(getTeacherProfileControllerProvider(teacherId));
        }
      });
    }

    return getTeacherProfileControllerState.when(
      data: (getTeacherProfileDto) => getTeacherProfileDto != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        getTeacherProfileDto.profilePhotoPath,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      getTeacherProfileDto.name,
                      style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header2),
                          color: ColorSet.of(context).text),
                    ),
                  ],
                ),
                getTeacherProfileDto.isFollowing
                    ? TextButtonForUnFollowTeacher(
                        onPressed: deleteFavoriteTeacher,
                      )
                    : TextButtonForFollowTeacher(
                        onPressed: addFavoriteTeacher,
                      ),
              ],
            )
          : Text(
              "プロフないっす、アカウント消したかもっす",
              style: TextStyle(color: ColorSet.of(context).text),
            ),
      loading: () => const LoadingOverlay(),
      error: (error, stack) {
        return Center(
            child: Column(
          children: [
            Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            )
            // TextForError(),
          ],
        ));
      },
    );
  }
}
