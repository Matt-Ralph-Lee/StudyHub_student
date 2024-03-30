import 'package:flutter/material.dart';

import '../../pages/create_question_page.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';

class ShowCreateQuestionBottomSheet extends StatelessWidget {
  const ShowCreateQuestionBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          BuildContext mainContext = context;
          //ipadだと画面いっぱいに広がらないのどうにかしたい
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: ColorSet.of(context).background,
            builder: (BuildContext context) {
              return SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQueryData.fromView(View.of(context)).padding.top,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CreateQuestionPage(),
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
        ));
  }
}
