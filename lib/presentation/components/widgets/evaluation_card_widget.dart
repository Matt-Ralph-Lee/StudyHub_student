import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../application/teacher_evaluation/application_service/get_teacher_evaluation_dto.dart';
import '../../controllers/get_student_controller/get_student_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../parts/text_for_error.dart';
import 'loading_overlay_widget.dart';

class EvaluationCardWidget extends ConsumerWidget {
  final GetTeacherEvaluationDto teacherEvaluationsDto;

  const EvaluationCardWidget({
    Key? key,
    required this.teacherEvaluationsDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final getStudentControllerState =
        ref.watch(getStudentControllerProvider(teacherEvaluationsDto.from));
    return Column(
      children: [
        Text(
          L10n.evaluationsTitleText,
          style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
            color: ColorSet.of(context).greyText,
          ),
        ),
        const SizedBox(
          height: 20,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getStudentControllerState.when(
                      data: (getStudentDto) => CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            getStudentDto.profilePhotoPath.contains("assets")
                                ? AssetImage(getStudentDto.profilePhotoPath)
                                    as ImageProvider
                                : NetworkImage(
                                    getStudentDto.profilePhotoPath,
                                  ),
                      ),
                      loading: () => const LoadingOverlay(),
                      error: (error, stack) {
                        return const Center(
                            child: Column(
                          children: [
                            TextForError(),
                          ],
                        ));
                      },
                    ),
                    Text(
                      DateFormat(L10n.dateFormat)
                          .format(teacherEvaluationsDto.createdAt),
                      style: TextStyle(
                        fontWeight: FontWeightSet.normal,
                        fontSize: FontSizeSet.getFontSize(
                            context, FontSizeSet.header3),
                        color: ColorSet.of(context).text,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            teacherEvaluationsDto.comment,
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
