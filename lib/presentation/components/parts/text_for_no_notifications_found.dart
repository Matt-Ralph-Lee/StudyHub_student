import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';
import '../../shared/constants/font_size_set.dart';
import '../../shared/constants/font_weight_set.dart';
import '../../shared/constants/l10n.dart';

class TextForNoNotificationsFound extends StatelessWidget {
  const TextForNoNotificationsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      L10n.noNotificationFound,
      style: TextStyle(
          color: ColorSet.of(context).text,
          fontWeight: FontWeightSet.normal,
          fontSize: FontSizeSet.getFontSize(context, FontSizeSet.body)),
    );
  }
}
