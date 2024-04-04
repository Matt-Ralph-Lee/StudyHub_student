import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_evaluation_found.dart';
import '../components/widgets/evaluation_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../components/widgets/teacher_profile_widget.dart';
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
      ),
      backgroundColor: ColorSet.of(context).background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            PaddingSet.getPaddingSize(
              context,
              PaddingSet.horizontalPadding,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTeacherProfileState.when(
                data: (teacherProfileDto) => teacherProfileDto != null
                    ? TeacherProfileWidget(
                        teacherProfileDto: teacherProfileDto,
                      )
                    : Text(
                        L10n.noTeacherProfileFoundText,
                        style: TextStyle(
                          fontWeight: FontWeightSet.normal,
                          fontSize: FontSizeSet.getFontSize(
                              context, FontSizeSet.header3),
                          color: ColorSet.of(context).text,
                        ),
                      ),
                loading: () => const LoadingOverlay(),
                error: (error, stack) => const Center(
                  child: TextForError(),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                L10n.evaluationsTitleText,
                style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.annotation),
                  color: ColorSet.of(context).greyText,
                ),
              ),
              const SizedBox(height: 10),
              getTeacherEvaluationState.when(
                data: (evaluations) => evaluations.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: evaluations.length,
                          itemBuilder: (context, index) {
                            return EvaluationCardWidget(
                              teacherEvaluationsDto: evaluations[index],
                            );
                          },
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
