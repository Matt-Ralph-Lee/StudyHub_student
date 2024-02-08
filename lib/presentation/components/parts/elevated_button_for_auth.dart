import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

//バリデーションとかはせず、文脈に依存せず、発火させる関数とtextさえあればいいから一個定義すればいいよね...？
class ElavatedButtonForAuth extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const ElavatedButtonForAuth({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed != null
              ? ColorSet.of(context).primary
              : ColorSet.of(context).inactiveGreySurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.annotation,
              //非活性時のテキスト色はどうする？？
              //unselectedTextだと見づらいかも
              color: onPressed != null
                  ? ColorSet.of(context).whiteText
                  : ColorSet.of(context).unselectedText),
        ),
      ),
    );
  }
}
