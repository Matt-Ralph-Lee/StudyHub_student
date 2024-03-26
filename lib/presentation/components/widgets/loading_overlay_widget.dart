import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSet.of(context).cardShadow, //これの色は？
      child: Center(
        child: CircularProgressIndicator(
          color: ColorSet.of(context).text,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
