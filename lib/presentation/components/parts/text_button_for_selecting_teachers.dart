import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/page_path.dart';

class TextButtonForSelectingTeacher extends StatelessWidget {
  final void Function(List<TeacherId>) selectTeachersFunction;
  const TextButtonForSelectingTeacher({
    Key? key,
    required this.selectTeachersFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void push(BuildContext context) {
      context.push(
        PageId.selectTeachers.path,
        extra: selectTeachersFunction,
      );
    }

    return TextButton(
      onPressed: () => push(context),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.people,
              size: FontSizeSet.header1, color: ColorSet.of(context).primary),
          SizedBox(
            width: 10,
          ),
          Text(
            "講師を選択する",
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.body,
                color: ColorSet.of(context).greyText), //ここの色は迷う
          ),
        ],
      ),
    );
  }
}
