import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class TextButtonForSelectingTeacher extends StatelessWidget {
  final void Function(TeacherId) selectTeachersFunction;
  final ValueNotifier<List<TeacherId>> selectedTeachers;
  final bool isTeacherSelected;
  const TextButtonForSelectingTeacher({
    Key? key,
    required this.selectTeachersFunction,
    required this.selectedTeachers,
    required this.isTeacherSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void push(BuildContext context) {
      context.push(
        PageId.selectTeachers.path,
        extra: [selectTeachersFunction, selectedTeachers],
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
          const SizedBox(
            width: 10,
          ),
          Text(
            isTeacherSelected
                ? L10n.changeTeachersTextButtonText
                : L10n.selectTeachersTextButtonText,
            style: TextStyle(
                fontWeight: isTeacherSelected
                    ? FontWeightSet.semibold
                    : FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body),
                color: isTeacherSelected
                    ? ColorSet.of(context).primary
                    : ColorSet.of(context).greyText), //ここの色は迷う
          ),
        ],
      ),
    );
  }
}
