// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../../domain/teacher/models/teacher_id.dart';
// import '../../shared/constants/color_set.dart';
// import '../../shared/constants/font_size_set.dart';

// import '../../shared/constants/page_path.dart';

// class ButtonForSelectingTeacher extends StatelessWidget {
//   final void Function(TeacherId) selectTeachersFunction;
//   final ValueNotifier<List<TeacherId>> selectedTeachers;
//   final bool isTeacherSelected;
//   const ButtonForSelectingTeacher({
//     Key? key,
//     required this.selectTeachersFunction,
//     required this.selectedTeachers,
//     required this.isTeacherSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     void push(BuildContext context) {
//       context.push(
//         PageId.selectTeachers.path,
//         extra: [selectTeachersFunction, selectedTeachers],
//       );
//     }

//     return GestureDetector(
//       onTap: () => push(context),
//       child: DottedBorder(
//         color: ColorSet.of(context).primary,
//         borderType: BorderType.RRect,
//         radius: const Radius.circular(10),
//         dashPattern: const [5.0, 2.0],
//         strokeWidth: 1.0,
//         child: Container(
//           alignment: Alignment.center,
//           width: screenWidth < 600 ? 160 : 240,
//           height: screenWidth < 600 ? 80 : 120,
//           child: Icon(
//             Icons.person_add_alt_1_rounded,
//             size: FontSizeSet.header1,
//             color: ColorSet.of(context).primary,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class ButtonForSelectingTeacher extends StatelessWidget {
  final void Function(TeacherId) selectTeachersFunction;
  final ValueNotifier<List<TeacherId>> selectedTeachers;
  final bool isTeacherSelected;
  const ButtonForSelectingTeacher({
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
