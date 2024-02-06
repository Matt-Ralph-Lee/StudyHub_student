import 'package:flutter/material.dart';
import 'package:studyhub/presentation/components/parts/sample_button.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class SampleWidget extends StatelessWidget {
  const SampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "sample widget",
            style: TextStyle(color: ColorSet.of(context).text),
          ),
          const SampleButton(),
        ],
      ),
    );
  }
}
