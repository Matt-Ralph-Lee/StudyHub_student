import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../controllers/get_photo_controller/get_photo_controller.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TeacherProfileForQuestionPageWidget extends ConsumerWidget {
  final GetTeacherProfileDto teacherProfileDto;

  const TeacherProfileForQuestionPageWidget(
      {super.key, required this.teacherProfileDto});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
      // height: screenWidth < 600 ? 50 : 70,
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
        padding: EdgeInsets.symmetric(
          vertical: screenWidth < 600 ? 15 : 30, //stackで縮まるので
          horizontal: screenWidth < 600 ? 20 : 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: screenWidth < 600 ? 15 : 22,
              backgroundImage: image,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              teacherProfileDto.name,
              style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: ColorSet.of(context).text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
