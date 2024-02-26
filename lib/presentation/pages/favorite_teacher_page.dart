import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

import '../components/widgets/favorite_teacher_card_widget.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class FavoriteTeachersPage extends StatelessWidget {
  const FavoriteTeachersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          'お気に入りの講師',
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        //実際はfirebaseから諸々取得しながらリストビューで回す
        child: const FavoriteTeacherCardWidget(
          name: 'モリ',
          bio: 'よろしくお願いします！',
          iconUrl:
              'https://lh3.google.com/pw/AP1GczMrGbt8sXjhH7nP09rTJx1tZ0cqgqwOHNU_hYkILaSr-RsqgLhdmwbv_D5okjYpt8ZZOnmNiG-Br5rbLsdiRZwt8eIxMQ=w862-h1148-s-no-gm?authuser=0',
        ),
      ),
    );
  }
}
