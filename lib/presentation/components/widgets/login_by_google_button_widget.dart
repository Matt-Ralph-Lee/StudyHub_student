import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';
import '../../shared/constants/page_path.dart';

class LoginByGoogleButtonWidget extends StatelessWidget {
  const LoginByGoogleButtonWidget({
    Key? key,
  }) : super(key: key);

  void push(BuildContext context) {
    context.push(PageId.loginByGoogle.path);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
          L10n.loginByGoogleButtonText,
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(
                context,
                FontSizeSet.annotation,
              ),
              color: ColorSet.of(context).text),
        ),
      ),
    );
  }
}
