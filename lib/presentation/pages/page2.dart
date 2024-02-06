import 'package:flutter/material.dart';
import "package:flutter_hooks/flutter_hooks.dart";
import 'package:studyhub/presentation/components/parts/sample_button.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class Page2 extends HookWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    // stateはHookWidgetを用いること
    final count = useState(0);

    void handleCount() {
      count.value += 1;
    }

    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "page2",
              style: TextStyle(color: ColorSet.of(context).questionIcon),
            ),
            Text(
              "${count.value}",
              style: TextStyle(color: ColorSet.of(context).answerIcon),
            ),
            SampleButton(
              fc: handleCount,
              child: Icon(
                Icons.add,
                color: ColorSet.of(context).icon,
              ),
            )
          ],
        ),
      ),
    );
  }
}
