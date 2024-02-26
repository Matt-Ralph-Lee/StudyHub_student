import 'package:flutter/material.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

class SearchTeachersPage extends StatelessWidget {
  const SearchTeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSet.of(context).background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("searchTeachersPage",
              style: TextStyle(color: ColorSet.of(context).primary)),
        ],
      ),
    );
  }
}
