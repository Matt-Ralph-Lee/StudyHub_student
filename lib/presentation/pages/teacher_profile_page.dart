import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/parts/text_button_for_follow_teacher.dart';
import '../components/parts/text_button_for_unfollow_teacher.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_evaluation_found.dart';
import '../components/widgets/evaluation_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../components/widgets/teacher_profile_widget.dart';
import '../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../controllers/get_teacher_evaluation_controller/get_teacher_evaluation_controller.dart';
import '../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';

class TeacherProfilePage extends ConsumerWidget {
  final TeacherId teacherId;
  const TeacherProfilePage({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTeacherProfileState =
        ref.watch(getTeacherProfileControllerProvider(teacherId));
    final getTeacherEvaluationState =
        ref.watch(getTeacherEvaluationControllerProvider(teacherId));

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, 30),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          L10n.teacherProfilePageTitle,
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
            color: ColorSet.of(context).text,
          ),
        ),
        actions: [
          getTeacherProfileState.when(
            data: (teacherProfileDto) => teacherProfileDto != null
                ? teacherProfileDto.isFollowing
                    ? TextButtonForUnFollowTeacher(
                        onPressed: deleteFavoriteTeacher,
                      )
                    : TextButtonForFollowTeacher(
                        onPressed: addFavoriteTeacher,
                      )
                : const SizedBox(),
            loading: () => const LoadingOverlay(),
            error: (error, stack) => const TextForError(),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTeacherProfileState.when(
              data: (teacherProfileDto) => teacherProfileDto != null
                  ? Padding(
                      padding: EdgeInsets.all(
                        PaddingSet.getPaddingSize(
                          context,
                          PaddingSet.horizontalPadding,
                        ),
                      ),
                      child: TeacherProfileWidget(
                        teacherProfileDto: teacherProfileDto,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(
                        PaddingSet.getPaddingSize(
                          context,
                          PaddingSet.horizontalPadding,
                        ),
                      ),
                      child: Text(
                        L10n.noTeacherProfileFoundText,
                        style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                          color: ColorSet.of(context).text,
                        ),
                      ),
                    ),
              loading: () => const LoadingOverlay(),
              error: (error, stack) => const Center(
                child: TextForError(),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingSet.getPaddingSize(
                    context,
                    PaddingSet.horizontalPadding,
                  ),
                ),
                child: getTeacherProfileState.when(
                  data: (teacherProfileDto) => Text(
                    L10n.evaluationsTitleText,
                    style: TextStyle(
                      fontWeight: FontWeightSet.normal,
                      fontSize: FontSizeSet.getFontSize(
                          context, FontSizeSet.annotation),
                      color: ColorSet.of(context).greyText,
                    ),
                  ),
                  loading: () => const LoadingOverlay(),
                  error: (error, stack) => const Center(
                    child: TextForError(), //ここは普通に評価なしで"生徒からの評価"みたいに出しとけば言い節はある
                  ),
                )),
            const SizedBox(height: 10),
            getTeacherEvaluationState.when(
              data: (evaluations) => evaluations.isNotEmpty
                  ? ExpandablePageView.builder(
                      controller: PageController(viewportFraction: 0.9),
                      scrollDirection: Axis.horizontal,
                      itemCount: evaluations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(
                            PaddingSet.getPaddingSize(
                              context,
                              PaddingSet.pageViewItemLightPadding,
                            ),
                          ),
                          child: EvaluationCardWidget(
                            teacherEvaluationsDto: evaluations[index],
                          ),
                        );
                      },
                    )
                  : const SizedBox(
                      height: 100,
                      child: Center(
                        child: TextForNoEvaluationFound(),
                      ),
                    ),
              loading: () => const LoadingOverlay(),
              error: (error, stack) => const Center(
                child: TextForError(),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
