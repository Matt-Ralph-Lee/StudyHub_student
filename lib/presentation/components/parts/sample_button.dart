import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';

class SampleButton extends StatelessWidget {
  // fcをnull許容にすることによって関数を与えられなかったら不活性化させる
  final VoidCallback? fc;
  final Widget child;
  const SampleButton({
    super.key,
    this.fc,
    this.child = const Text("unimplemented"),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorSet.of(context).primary,
          foregroundColor: ColorSet.of(context).whiteText,
          disabledBackgroundColor: ColorSet.of(context).inactiveGreySurface,
          disabledForegroundColor: ColorSet.of(context).greyText),
      onPressed: fc,
      child: child,
    );
  }
}
