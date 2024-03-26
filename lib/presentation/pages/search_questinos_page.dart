import 'package:flutter/material.dart';

import '../shared/constants/color_set.dart';

class SearchQuestionsPage extends StatelessWidget {
  const SearchQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Text(
        "質問探すページ",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
