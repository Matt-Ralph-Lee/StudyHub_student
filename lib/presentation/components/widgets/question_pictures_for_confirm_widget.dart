import 'dart:io';

import 'package:flutter/material.dart';

class QuestionPictureForConfirmWidget extends StatelessWidget {
  final String photoPath;

  const QuestionPictureForConfirmWidget({
    Key? key,
    required this.photoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.file(
        File(photoPath),
        // width: 200, TODO: 画像サイズによる条件分岐
        //←height指定してfitをcontainにしちゃえば問題ない？気がする？by森脇
        height: screenWidth < 600 ? 130 : 200,
        fit: BoxFit.contain,
      ),
    );
  }
}
