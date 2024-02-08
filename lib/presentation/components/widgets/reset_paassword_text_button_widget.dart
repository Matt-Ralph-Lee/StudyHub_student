import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/page_path.dart';
import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class ResetPaasswordTextButtonWidget extends StatelessWidget {
  const ResetPaasswordTextButtonWidget({super.key});

  void push(BuildContext context) {
    print("test");
    context.push(PageId.resetPassword.path);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => push(context),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Text(
        "パスワードを忘れた方はこちら",
        style: TextStyle(
            fontWeight: FontWeightSet.normal,
            fontSize: FontSizeSet.annotation,
            color: ColorSet.of(context).text),
      ),
    );
  }
}
