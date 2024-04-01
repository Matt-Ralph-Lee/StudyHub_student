import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/presentation/controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';

import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import 'create_question_page.dart';

class SearchQuestionsPage extends ConsumerWidget {
  const SearchQuestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Column(
        children: [
          Text(
            "質問探すページ",
            style: TextStyle(color: ColorSet.of(context).text),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(addFavoriteTeacherControllerProvider.notifier)
                  .addFavoriteTeacher(TeacherId("00000000000000000001"));
              print("added favorite teacher");
            },
            child: Text(
              "add one favorite teacher",
              style: TextStyle(
                color: ColorSet.of(context).text,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                //ipadだと画面いっぱいに広がらないのどうにかしたい
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQueryData.fromView(View.of(context))
                              .padding
                              .top,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const CreateQuestionPage(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.add,
                color: ColorSet.of(context).text,
                size: FontSizeSet.getFontSize(
                  context,
                  FontSizeSet.header1,
                ),
              )),
        ],
      ),
    );
  }
}
