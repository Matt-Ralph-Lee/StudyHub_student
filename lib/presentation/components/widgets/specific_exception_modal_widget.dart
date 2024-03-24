import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class SpecificExceptionModalWidget extends StatelessWidget {
  final String errorMessage;
  const SpecificExceptionModalWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorSet.of(context).surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 12), //textButtonが領域多めに取るのでバランス的にbottomだけ12px
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              L10n.errorModalText,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.body,
                  color: ColorSet.of(context).text),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              errorMessage,
              style: TextStyle(
                  fontWeight: FontWeightSet.normal,
                  fontSize: FontSizeSet.body,
                  color: ColorSet.of(context).text),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              child: Text(
                L10n.modalCloseText,
                style: TextStyle(
                    fontWeight: FontWeightSet.normal,
                    fontSize: FontSizeSet.body,
                    color: ColorSet.of(context).text),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
