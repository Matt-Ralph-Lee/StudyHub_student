import 'package:flutter/material.dart';
import 'package:studyhub/presentation/components/widgets/sample_widget.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ColorSetにcontextを渡して、使いたい色を指定する
          Text("page 1", style: TextStyle(color: ColorSet.of(context).primary)),
          const SampleWidget(),
        ],
      ),
    );
  }
}
