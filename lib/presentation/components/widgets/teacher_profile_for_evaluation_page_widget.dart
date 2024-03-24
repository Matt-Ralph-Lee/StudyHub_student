import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studyhub/application/teacher/application_service/get_teacher_profile_dto.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../parts/text_button_for_follow_teacher.dart';
import '../parts/text_button_for_unfollow_teacher.dart';

class TeacherProfileForEvaluationPageWidget extends StatelessWidget {
  final GetTeacherProfileDto getTeacherProfileDto;
  final VoidCallback followFunction;
  final VoidCallback unFollowFunction;
  final bool isFollowed;
  const TeacherProfileForEvaluationPageWidget({
    super.key,
    required this.getTeacherProfileDto,
    required this.followFunction,
    required this.isFollowed,
    required this.unFollowFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
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
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.header2),
                  color: ColorSet.of(context).text),
            ),
          ],
        ),
        isFollowed
            ? TextButtonForFollowTeacher(
                onPressed: followFunction,
              )
            : TextButtonForUnFollowTeacher(
                onPressed: unFollowFunction,
              ),
      ],
    );
  }
}
