import 'package:flutter/material.dart';

import '../../../application/teacher/application_service/get_teacher_profile_dto.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class TeacherProfileWForConfirmWidget extends StatelessWidget {
  final GetTeacherProfileDto teacherProfileDto;

  const TeacherProfileWForConfirmWidget(
      {super.key, required this.teacherProfileDto});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
          vertical: screenWidth < 600 ? 5 : 10,
          horizontal: screenWidth < 600 ? 20 : 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage:
                  teacherProfileDto.profilePhotoPath.contains("assets")
                      ? AssetImage(teacherProfileDto.profilePhotoPath)
                          as ImageProvider
                      : NetworkImage(
                          teacherProfileDto.profilePhotoPath,
                        ),
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
