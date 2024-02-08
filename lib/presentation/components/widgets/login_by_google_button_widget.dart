import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';

class LoginByGoogleButtonWidget extends StatelessWidget {
  const LoginByGoogleButtonWidget({
    Key? key,
  }) : super(key: key);

  push(BuildContext context) {
    context.push('/login_by_google');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: OutlinedButton(
        onPressed: () => push(context),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.5, color: ColorSet.of(context).text),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          "Googleでログインする",
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.annotation,
              color: ColorSet.of(context).text),
        ),
      ),
    );
  }
}
