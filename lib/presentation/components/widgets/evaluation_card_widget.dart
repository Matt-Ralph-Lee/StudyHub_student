import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../application/teacher_evaluation/application_service/get_teacher_evaluation_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../controllers/get_student_controller/get_student_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final getStudentControllerState =
        ref.watch(getStudentControllerProvider(teacherEvaluationsDto.from));

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
          PaddingSet.getPaddingSize(
            context,
            PaddingSet.pageViewItemLightPadding,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                getStudentControllerState.when(
                  data: (getStudentDto) {
                    final image = ref
                        .watch(getPhotoControllerProvider(
                            getStudentDto.profilePhotoPath))
                        .maybeWhen(
                          data: (d) => d,
                          orElse: () => const AssetImage(
                              "assets/images/sample_picture_hd.jpg"),
                        );
                    return CircleAvatar(
                      radius: screenWidth < 600 ? 15 : 22,
                      backgroundImage: image,
                    );
                  },
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
                      context,
                      FontSizeSet.annotation,
                    ),
                    color: ColorSet.of(context).text,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: teacherEvaluationsDto.rating.toDouble(),
                  ignoreGestures: true,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                  itemPadding: EdgeInsets.only(
                      right: PaddingSet.getPaddingSize(
                    context,
                    5,
                  )),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: ColorSet.of(context).primary,
                    size: FontSizeSet.getFontSize(context, FontSizeSet.body),
                  ),
                  onRatingUpdate: (double value) {},
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  teacherEvaluationsDto.rating.toString(),
                  style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.body),
                    color: ColorSet.of(context).text,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                            context,
                            FontSizeSet.body,
                          ),
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
    );
  }
}
