import 'package:flutter/material.dart';

import '../../pages/create_question_page.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';

class ShowCreateQuestionBottomSheet extends StatelessWidget {
  const ShowCreateQuestionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          //ipadだと画面いっぱいに広がらないのどうにかしたい
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const CreateQuestionPage();
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
        ));
  }
}
