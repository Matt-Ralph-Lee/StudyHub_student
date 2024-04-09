import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/padding_set.dart';

class TeacherProfileWidget extends ConsumerWidget {
  final GetTeacherProfileDto teacherProfileDto;

  const TeacherProfileWidget({super.key, required this.teacherProfileDto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final image = ref
        .watch(getPhotoControllerProvider(teacherProfileDto.profilePhotoPath))
        .maybeWhen(
          data: (d) => d,
          orElse: () => const AssetImage("assets/images/sample_picture_hd.jpg"),
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
                const SizedBox(
                  width: 20,
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: teacherProfileDto.rating.toDouble(),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            teacherProfileDto.rating.toString(),
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
              ],
            ),
            const SizedBox(
              height: 20,
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
                      const SizedBox(
                        height: 3,
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
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
            const SizedBox(
              height: 20,
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
                      const SizedBox(
                        height: 3,
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
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
            const SizedBox(
              height: 20,
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
                      const SizedBox(
                        height: 3,
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
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
            const SizedBox(
              height: 20,
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
                        "経歴",
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Divider(
                        color: ColorSet.of(context).greyText,
                        thickness: 0.5,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${teacherProfileDto.highSchool}${L10n.fromText}\n${teacherProfileDto.university}${L10n.enrollmentText}",
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
