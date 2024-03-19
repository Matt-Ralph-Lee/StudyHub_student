import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/teacher/models/teacher_id.dart';
import '../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/page_path.dart';

class EvaluationPage extends ConsumerWidget {
  const EvaluationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;

    void push(BuildContext context) {
      context.push(PageId.favoriteTeachers.path);
    }

    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
            child: Text(
              "キャンセル",
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize:
                      FontSizeSet.getFontSize(context, FontSizeSet.header3),
                  color: ColorSet.of(context).text),
            ),
            onPressed: () => context.pop(),
          ),
          backgroundColor: ColorSet.of(context).background,
          actions: [
            TextButton(
              child: Text(
                "評価する",
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize:
                        FontSizeSet.getFontSize(context, FontSizeSet.header3),
                    color: ColorSet.of(context).primary),
              ),
              onPressed: () => push(context),
            ),
          ],
        ),
        backgroundColor: ColorSet.of(context).background,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorSet.of(context).primary,
              foregroundColor: ColorSet.of(context).whiteText,
            ),
            child: const Text("おきに講師追加ボタン"),
            onPressed: () async {
              final addFavoriteTeacherController =
                  ref.read(addFavoriteTeacherControllerProvider.notifier);
              await addFavoriteTeacherController
                  .addFavoriteTeacher(TeacherId('00000000000000000001'));
            },
          ),
        ));
  }
}
