import 'package:flutter/material.dart';

import '../../shared/constants/color_set.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorSet.of(context).text,
      strokeWidth: 3.0,
    );
  }
}
